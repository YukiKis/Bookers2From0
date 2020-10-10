require 'rails_helper'

RSpec.describe Message, type: :model do
  context "on validation" do
    let(:user){ create(:user1) }
    it "belongs_to user" do
      expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to room" do
      expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
    end
    it "is valid" do
      room = Room.new
      message = user.messages.new(message: "Message")
      message.room = room
      expect(message).to be_valid
    end
    it "is invalid without message" do
      message = user.messages.new
      expect(message).to be_invalid
    end
  end
end
