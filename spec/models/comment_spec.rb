require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "on validation" do
    let(:user){ create(:user1) }
    let(:book){ create(:book1, user: user) }
    it "belongs_to user" do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to book" do
      expect(Comment.reflect_on_association(:book).macro).to eq :belongs_to
    end
    it "is valid" do
      comment = Comment.new
      comment.user = user
      comment.book = book
      comment.comment = "Hello"
      expect(comment).to be_valid
    end
    it "is invalid without user" do
      comment = Comment.new
      comment.book = book
      comment.comment = "Hello"
      expect(comment).to be_invalid
    end
    it "is invalid without book" do
      comment = user.comments.new
      comment.comment = "Hello"
      expect(comment).to be_invalid
    end
    it "is invalid without comment itself" do
      comment = user.comments.new
      comment.book = book
      expect(comment).to be_invalid
    end
  end
end
