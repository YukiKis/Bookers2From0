require 'rails_helper'

RSpec.describe "Homes", type: :system do
  context "when on root page" do
    before do
      visit root_path
    end
    it "has login button" do
      expect(page).to have_link "Login", href: new_user_session_path
    end
    it "has signup button" do
      expect(page).to have_link "Signup", href: new_user_registration_path
    end
  end

  context "when on about page" do
    it "has 'About'" do
      visit about_path
      expect(page).to have_content "ABOUT"
    end
  end
end
