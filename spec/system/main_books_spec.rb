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
      visit books_path
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
    # it "has a heart to make a favorite" do
    #   expect(page).to have_link "heart", href: book_favorite_path(book1)
    # end
    # it "succeeds to make a favorite" do
    #   before_count = book1.favorites.count
    #   click_link "heart", href: book_favorite_path(book1)
    #   expect(current_path).to eq book_path(book1)
    #   after_count = book1.favorites.count
    #   expect(before_count).not_to eq after_count
    # end
    # it "has a red heart to delete favorite" do 
    #   expect(page).to have_link "red-heart", href: book_favorite_path(book1)
    #   expect(page).to have_content "red-heart"
    # end
    # it "succeeds to destroy a favorite" do
    #   before_count = book1.favorites.count
    #   click_link "red-heart", href: book_path(book1)
    #   expect(current_path).to eq book_path(book1)
    #   after_count = book1.favorites.count
    #   expect(before_count).not_to eq after_count
    # end

    it "has search-form" do
      expect(page).to have_field "search[search]"
      expect(page).to have_select("search[user_book]", options: ["Users", "Books"])
      expect(page).to have_select("search[how]", options: ["完全一致", "前方一致", "後方一致", "部分一致"])
      expect(page).to have_button "SEARCH"
    end

    it "succeeds to search by user_whole" do
      fill_in "search[search]", with: book1.user.name
      select "Users", from: "search[user_book]"
      select "完全一致", from: "search[how]"
      click_button "SEARCH"
      expect(current_path).to eq books_search_path
      expect(page).to have_content book1.title
    end
    it "succeeds to search by book_partial" do
      fill_in "search[search]", with: book1.title.chars[0..2].join
      select "Books", from: "search[user_book]"
      select "部分一致", from: "search[how]"
      click_button "SEARCH"
      expect(current_path).to eq books_search_path
      expect(page).to have_content book1.title
    end
    # it "fails to search" do
    #   click_button "SEARCH"
    #   expect(current_path).to eq books_search_path
    #   expect(page).to have_content "Please fill in search word"
    # end
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
    # it "has a heart to make a favorite" do
    #   expect(page).to have_link "heart", href: book_favorite_path(book1)
    # end
    # it "succeeds to make a favorite" do
    #   before_count = book1.favorites.count
    #   click_link "heart", href: book_favorite_path(book1)
    #   expect(current_path).to eq book_path(book1)
    #   after_count = book1.favorites.count
    #   expect(before_count).not_to eq after_count
    # end
    # it "has a red heart to delete favorite" do 
    #   expect(page).to have_link "red-heart", href: book_favorite_path(book1)
    #   expect(page).to have_content "red-heart"
    # end
    # it "succeeds to destroy a favorite" do
    #   before_count = book1.favorites.count
    #   click_link "red-heart", href: book_favorite_path(book1)
    #   expect(current_path).to eq book_path(book1)
    #   after_count = book1.favorites.count
    #   expect(before_count).not_to eq after_count
    # end

    it "has comment-list" do
      user2.comments.create(book: book1, comment: "Interesting")
      comments = book1.comments
      comments.each do |comment|
        expect(page).to have_link comment.user.name, href: user_path(comment.user)
        expect(page).to have_content comment.comment
        if comment_user == current_user
          expect(page).to have_link "Destroy", href: book_comment_path
        end
      end
    end

    it "has comment-form" do
      expect(page).to have_field "comment[comment]"
      expect(page).to have_button "POST" 
    end

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
    it "not able to get edit link if it is NOT the user" do
      click_link "LOGOUT"
      visit new_user_session_path
      fill_in "user[name]", with: user2.name
      fill_in "user[password]", with: user2.password
      click_button "Login"
      visit edit_book_path(book1)
      expect(current_path).to eq user_path(book1.user)
    end
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