require 'rails_helper'

RSpec.describe "Chats", type: :system do
  context "when on show page" do
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2) }
  end
  before do
    visit new_user_session_path
    fill_in "user[name]", with: user1.name
    fill_in "user[password]", with: user1.password
    click_button "Login"
    visit user_path(user2)
    click_button "Start Chatting"
  end
  it "has 'Chat Room'" do
    expect(page).to have_content "Chat Room"
  end
  it "has name of users" do
    expect(page).to have_link user1.name, user_path(user1)
    expect(page).to have_link user2.name, user_path(user2)
  end
  it "has form and button to post message" do
    expect(page).to have_field message[message]
    expect(page).to have_button "POST"
  end
  it "has messages" do
    messages = room.messages.all
    messages.each do |message|
      expect(page).to have_content message.user.name
      expect(page).to have_content message.message
    end
  end
  it "has back to own page" do 
    expect(page).to have_link "Back", href: user_path(user1)
  end
end
