require 'rails_helper'

RSpec.describe "Mains", type: :system do
  context "when logged_in" do
    let(:user){ create(:user1) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      visit user_path(user)
    end
    it "is on user-show page" do
      expect(current_path).to eq user_path(user)
    end    
  end

  context "when not logged in" do
    let(:user){ create(:user1) }
    it "every page returns to login_page" do
      visit users_path
      expect(current_path).to eq new_user_session_path
      visit user_path(user)
      expect(current_path).to eq new_user_session_path
      visit edit_user_path(user)
      expect(current_path).to eq new_user_session_path
    end
  end

  context "when on user-show" do
    let(:user){ create(:user1) }
    let(:user2){ create(:user2) }
    let(:book1){ create(:book1, user: user) }
    let(:book2){ create(:book2, user: user) }
    
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      visit user_path(user)
    end

    it "has 'User info'" do
      expect(page).to have_content "User info"
    end
    it "has user name" do
      expect(page).to have_content user.name
    end
    it "has user introducion" do
      expect(page).to have_content user.introduction
    end
    it "has user profile_image" do
      expect(page).to have_css "img.profile_image"
    end
    it "has follow_link" do
      visit user_path(user2)
      expect(page).to have_link "Follow", href: user_relationships_path(user2)
    end
    it "has unfollow link" do
      visit user_path(user2)
      click_link "Follow"
      expect(page).to have_link "Unfollow", href: user_relationships_path(user2)
    end
    it "succeeds to follow" do
      visit user_path(user2)
      click_link "Follow"
      expect(page).to have_link "Unfollow"
    end
    it "succeeds to unfollow" do
      visit user_path(user2)
      click_link "Follow"
      click_link "Unfollow"
      expect(page).to have_link "Follow"
    end
    it "has book form to post" do
      expect(page).to have_field "book[title]"
      expect(page).to have_field "book[body]"
      expect(page).to have_button "Create Book"
    end
    it "has user's books" do
      user.books.each do |book|
        expect(page).to have_content book.title
        expect(page).to have_link book.title, href: book_path(book)
      end
    end
    it "has button to start chat" do
      expect(page).to have_button "Start Chatting"
    end
    it "has button to restart chat" do
      room = Room.create
      entry = user.entries.creaet(room: room)
      expect(page).to have_link "Chatting", href: room_path(room)
    end
  end

  context "when on user-index page" do
    let(:user1){ create(:user1) } 
    let(:user2){ create(:user2) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user1.name
      fill_in "user[password]", with: user1.password
      click_button "Login" 
      visit users_path
    end
    it "has 'User info'" do
      expect(page).to have_content "User info"
    end
    it "has user name" do
      expect(page).to have_content user1.name
    end
    it "has user introcution" do
      expect(page).to have_content user1.introduction
    end
    it "has user profile image" do
      expect(page).to have_css "img.profile_image"
    end
    it "has 'Users'" do
      expect(page).to have_content "Users"
    end
    it "has users information" do
      User.all.each do |user|
        expect(page).to have_link "", href: user_path(user)
        expect(page).to have_link user.name, href: user_path(user)
        expect(page).to have_content user.books.count
      end
    end
  end

  context "when on user-edit page" do
    let(:user){ create(:user1) }
    let(:user2){ create(:user2) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      visit edit_user_path(user)
    end
    it "has contents" do
      expect(page).to have_content "Editing"
      expect(page).to have_field "user[name]"
      expect(page).to have_field "user[introduction]"
      expect(page).to have_field "user[profile_image]"
      expect(page).to have_button "Update User"
    end
    it "returns to user-show if it is not current_user" do
      visit edit_user_path(user2)
      expect(current_path).to eq user_path(user2)
    end
    it "update properly" do
      click_button "Update User"
      expect(page).to have_content "successfully"
      expect(current_path).to eq user_path(user)
    end
    it "Not update" do
      fill_in "user[name]", with: ""
      click_button "Update User"
      expect(page).to have_content "error"
      expect(current_path).to eq user_path(user)
    end

  end
end
