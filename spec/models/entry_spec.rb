require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:user){ create(:user1) }
  context "on validation" do
    it "belongs_to user" do
      expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to room" do
      expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
    end
    it "is valid" do
      room = Room.new
      entry = Entry.new
      entry.user = user
      entry.room = room
      expect(room).to be_valid
    end
    it "is invalid without room" do
      entry = user.entries.new
      expect(entry).to be_invalid
    end
  end
end
