require 'rails_helper'

RSpec.describe "Headers", type: :system do

  context "with header when not logged in" do
    before do
      visit root_path
    end
    it "has 'HOME' link to home" do
      expect(page).to have_content "HOME"
    end
    it "has 'ABOUT' link to about" do
      expect(page).to have_content "ABOUT"      
    end
    it "has 'LOGIN' link to login" do
      expect(page).to have_content "LOGIN"
    end
    it "has 'SIGNUP' link to signup" do
      expect(page).to have_content "SIGNUP"
    end
  end
  
  context "when trying to jump to link when not logged in" do
    before do
      visit root_path
    end

    it "jumps to home" do
      click_on "HOME"
      expect(current_path).to eq root_path
    end
    it "jumps to about" do
      click_on "ABOUT"
      expect(current_path).to eq about_path
    end
    it "jumps to login" do
      click_link "LOGIN"
      expect(current_path).to eq new_user_session_path
    end
    it "jumps to sign up" do
      click_link "SIGNUP"
      expect(current_path).to eq new_user_registration_path
    end
  end

  context "on header when logged in" do
    let(:user){ create(:user1) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      visit user_path(user)
    end
    it "has Home link to user-show page" do
      expect(page).to have_link "HOME", href: user_path(user)
    end
    it "has BOOKS link to books-index" do
      expect(page).to have_link "BOOKS", href: books_path
    end
    it "has USERS link to users-index" do
      expect(page).to have_link "USERS", href: users_path
    end
    it "has LOGOUT link to logout" do
      expect(page).to have_link "LOGOUT", href: destroy_user_session_path
    end
  end
end
