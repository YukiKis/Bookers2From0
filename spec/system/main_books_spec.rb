require 'rails_helper'

RSpec.describe "MainBooks", type: :system do
  context "on sidebar on index page" do
    let(:user1){ create(:user1) }
    let(:book1){ build(:book1) }
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
    it "has user introduction" do
      expect(page).to have_content user1.introduction
    end
    it "has user profile_image" do
      expect(page).to have_css "img.profile_image"
    end
    it "has user setting button" do
      expect(page).to have_link "SETTING", href: edit_user_path(user1)
    end
    it "has form for making a book" do
      expect(page).to have_field "book[title]"
      expect(page).to have_field "book[body]"
      expect(page).to have_button "Create Book"
    end
    it "succeeds to make a book" do
      before_count = Book.all.count
      fill_in "book[title]", with: book1.title
      fill_in "book[body]", with: book1.body
      click_button "Create Book"
      after_count = Book.all.count
      expect(after_count).not_to eq before_count
    end
    # it "fails to make a booK" do
    #   before_count = Book.all.count
    #   click_button "Create Book"
    #   after_count = Book.all.count
    #   expect(after_count).to eq before_count
    # end
  end

  context "on sidebar on show page" do
    let(:user1){ create(:user1) }
    let(:book1){ create(:book1, user: user1) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user1.name
      fill_in "user[password]", with: user1.password
      click_button "Login"
      visit user_path(user1)
    end
    it "has 'User info'" do
      expect(page).to have_content "User info"
    end
    it "has user name" do
      expect(page).to have_content user1.name
    end
    it "has user introduction" do
      expect(page).to have_content user1.introduction
    end
    it "has user profile_image" do
      expect(page).to have_css "img.profile_image"
    end
    it "has user setting button" do
      expect(page).to have_link "SETTING", href: edit_user_path(user1)
    end
    it "has form for making a book" do
      expect(page).to have_field "book[title]"
      expect(page).to have_field "book[body]"
      expect(page).to have_button "Create Book"
    end
    it "succeeds to make a book" do
      before_count = Book.all.count
      fill_in "book[title]", with: book1.title
      fill_in "book[body]", with: book1.body
      click_button "Create Book"
      expect(Book.all.count).not_to eq before_count
    end
    # it "fails to make a booK" do
    #   before_count = Book.all.count
    #   click_button "Create Book"
    #   expect(Book.all.count).to eq before_count
    # end
  end


  context "when on book-index page" do
    let(:user1){ create(:user1) }
    let(:book1){ create(:book1, user: user1) }
    let(:book2){ create(:book2, user: user1) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user1.name
      fill_in "user[password]", with: user1.password
      click_button "Login"
      visit users_path
    end
    it "has 'Books'" do
      expect(page).to have_content "Books"
    end
    it "has book lists" do
      Book.all.each do |book|
        expect(page).to have_link "", href: user_path(book.user)
        expect(page).to have_content book.title
        expect(page).to have_link "Show", href: book_path(book)
      end
    end
  end

  context "when on book-show page" do
    let(:user1){ create(:user1) }
    let(:user2){ create(:user2) }
    let(:book1){ create(:book1, user: user1) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user1.name
      fill_in "user[password]", with: user1.password
      click_button "Login"
      visit book_path(book1)
    end
    it "has 'Book detail'" do
      expect(page).to have_content "Book detail"
    end
    it "has book-information" do
      expect(page).to have_link "", href: user_path(book1.user)
      expect(page).to have_link book1.user.name, href: user_path(book1.user)
      expect(page).to have_content book1.body
    end
    it "has edit link if it is THE user" do
      expect(page).to have_link "Edit", href: edit_book_path(book1)
    end
    it "has destroy link if it is THE usr" do
      expect(page).to have_link "Destroy", href: book_path(book1)
    end
    # it "NOT have edit link if it is NOT the user" do
    #   visit destroy_user_session_path(user1)
    #   visit new_user_session_path
    #   fill_in "user[name]", with: user2.name
    #   fill_in "user[password]", with: user2.password
    #   click_button "Login"
    #   visit book_path(book1)
    #   expect(page).not_to have_link "Edit", href: book_path(book1)
    # end
    # it "NOT have destroy link if it is NOT the user" do
    #   visit destroy_user_session_path(user1)
    #   visit new_user_session_path
    #   fill_in "user[name]", with: user2.name
    #   fill_in "user[password]", with: user2.password
    #   click_button "Login"
    #   visit book_path(book1)
    #   expect(page).not_to have_link "Destroy", href: book_path(book1)
    # end
  end
  context "when on book-edit page" do
    let(:user1){ create(:user1) }
    let(:user2){ create(:user2) }
    let(:book1){ create(:book1, user: user1) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user1.name
      fill_in "user[password]", with: user1.password
      click_button "Login"
      visit edit_book_path(book1)
    end
    # it "not able to get edit link if it is NOT the user" do
    #   click_link "LOGOUT"
    #   visit new_user_session_path
    #   fill_in "user[name]", user2.name
    #   fill_in "user[password]", user2.password
    #   click_button "Login"
    #   visit edit_book_path(book1)
    #   expect(current_path).to eq user_path(book1.user)
    # end
    it "has 'Editing book'" do
      expect(page).to have_content "Editing book"
    end
    it "has title form" do
      expect(page).to have_field "book[title]", with: book1.title
    end
    it "has body form" do
      expect(page).to have_field "book[body]", with: book1.body
    end
    it "has Update Book button" do
      expect(page).to have_button "Update Book"
    end
    it "succeeds to update" do
      click_button "Update Book"
      expect(page).to have_content "successfully"
      expect(current_path).to eq book_path(book1)
    end
    it "fails to update" do
      fill_in "book[title]", with: ""
      click_button "Update Book"
      expect(page).to have_content "error"
      expect(current_path).to eq book_path(book1)
    end
  end
  context "when trying to destroy" do
    let(:user){ create(:user1) }
    let(:user2){ create(:user2) }
    let(:book){ create(:book1, user: user) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      visit book_path(book)
    end
    it "succeeds to destroy" do
      before_count = Book.all.count
      click_link "Destroy"
      after_count = Book.all.count
      expect(before_count).not_to eq after_count
    end
  end
end