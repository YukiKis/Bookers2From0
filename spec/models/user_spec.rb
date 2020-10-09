require 'rails_helper'

RSpec.describe User, type: :model do
  context "on validation" do
    let(:user){ build(:user) }
    it "is valid" do
      expect(user).to be_valid
    end
    it "is invalid with no name" do
      user.name = ""
      expect(user).to be_invalid
    end
    it "is invalid without email" do
      user.email = ""
      expect(user).to be_invalid
    end
    it "has many books" do
      expect(User.reflect_on_association(:books).macro).to eq :has_many
    end
  end
end
