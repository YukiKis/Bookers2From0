require 'rails_helper'

RSpec.describe Book, type: :model do
  context "when on validateion" do
    let(:user){ create(:user) }
    let(:book){ build(:book1, user: user) }
    it "is valid" do
      expect(book).to be_valid
    end
    it "is invalid without title" do
      book.title = ""
      expect(book).to be_invalid
    end
    it "is invalid without body" do
      book.body = ""
      expect(book).to be_invalid
    end
    it "has a user" do
      expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end
