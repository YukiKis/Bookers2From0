require 'rails_helper'

RSpec.describe Favorite, type: :model do
  context "on validation" do
    let(:user){ create(:user1) }
    let(:book){ create(:book1, user: user) }
    it "belongs to user" do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs to user" do
      expect(Favorite.reflect_on_association(:book).macro).to eq :belongs_to
    end
    it "is validate" do
      favorite = user.favorites.new
      favorite.book = book
      expect(favorite).to be_valid
    end
    it "is invalid without book" do
      favorite = user.favorites.new
      expect(favorite).to be_invalid
    end
    it "is invalid without user" do
      favorite = Favorite.new
      favorite.book = book
      expect(favorite).to be_invalid
    end
    # it "is invalid to have 2 favories on the same book by same user" do
    #   user.favorites.create(book: book)
    #   before_count = book.favorites.count
    #   fav = user.favorites.new(book: book)
    #   fav.save
    #   after_count = book.favorites.count
    #   expect(before_count).to eq after_count
    # end
  end
end
