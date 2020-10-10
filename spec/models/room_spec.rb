require 'rails_helper'

RSpec.describe Room, type: :model do
  context "on validation" do
    let(:user) { create(:user1) }
    it "has many entries" do
      expect(Room.reflect_on_association(:entries).macro).to eq :has_many
    end
    it "has many messages" do
      expect(Room.reflect_on_association(:messages).macro).to eq :has_many
    end
    it "is valid" do
      room = Room.new
      entry = user.entries.new(room: room)
      message = user.messages.create(message: "Hello", room: room)
      room.entries << entry
      room.messages < messages
      expect(room).to be_valid
    end
    it "is invalid without room" do
      room = Room.new
      message = user.messages.create(message: "Hello")
      room.messages << message
      expect(room).to be_invalid
    end
  end
end
