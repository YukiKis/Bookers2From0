require 'rails_helper'

RSpec.describe "Devises", type: :system do
  context "check contents" do
    before do
      visit new_user_registration_path
    end
    it "has name field" do
      expect(page).to have_field "user[name]"
    end
    it "has email field" do
      expect(page).to have_field "user[email]"
    end
    it "has password field" do
      expect(page).to have_field "user[password]"
    end
    it "has password_confirmation field" do
      expect(page).to have_field "user[password_confirmation]"
    end
  end

  context "when on registration page" do
    before do
      visit new_user_registration_path
    end
    let(:user){ create(:user) }
    it "succeeds to make user" do
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      fill_in "user[password_confirmation]", with: user.password_confirmation
      click_button "Signup"
      expect(page).to have_content "successfully"
      # expect(current_path).to eq user_path(current_user)
    end
    it "fails to make user" do
      click_button "Signup"
      expect(page).to have_content "error"
    end
  end
  context "when on login page" do
    let(:user){ create(:user) }
    before do
      visit new_user_session_path
    end
    it "succeeds to login" do
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      expect(page).to have_content "successfully"
      expect(current_path).to eq user_path(user)
    end
    it "fails to login" do
      click_button "Login"
      expect(current_path).to eq new_user_session_path
    end
  end
end
