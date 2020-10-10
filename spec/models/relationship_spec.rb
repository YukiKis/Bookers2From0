require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context "on active_relationship validation" do
    let(:user1){ create(:user1) }
    let(:user2){ create(:user2) } 
    it "is valid" do
      active_relationship = user1.active_relationships.new(followed: user2)
      expect(active_relationship).to be_valid
    end
    it "is invalid without followed_id" do
      active_relationship = user1.active_relationships.new
      expect(active_relationship).to be_invalid
    end
    it "increases number of follower after making rel" do
      rel_before_count = user2.passive_relationships.count
      follower_before_count = user2.followers.count
      user1.active_relationships.create(followed_id: user2)
      rel_after_count = user2.passive_relationships.count
      follower_after_count = user2.followers.count
      expect(rel_before_count).to eq rel_after_count
      expect(follower_before_count).to eq follower_after_count
    end

    it "increases number of following after making rel" do
      rel_before_count = user2.passive_relationships.count
      following_before_count = user1.following.count
      user1.active_relationships.create(followed_id: user2)
      rel_after_count = user2.passive_relationships.count
      following_after_count = user1.following.count
      expect(following_before_count).to eq following_after_count
    end

    # it "decreases number of following after deleting rel" do
    #   user1.active_relationships.create(followed_id: user2)
    #   before_rel_count = user1.active_relationships.count
    #   before_following_count = user1.following.count
    #   user1.active_relationships.find_by(followed_id: user2).destroy
    #   after_rel_count = user1.active_relationships.count
    #   after_following_count = user1.following.count
    #   expect(before_rel_count).not_to eq after_rel_count
    #   expect(before_following_count).not_to eq after_following_count
    # end

    # it "decreases number of follower after deleting rel" do
    #   user1.active_relationships.create(followed: user2)
    #   before_rel_count = user2.passive_relationships.count
    #   before_follower_count = user2.followers.count
    #   user1.active_relationships.find_by(followed: user2).destroy
    #   after_rel_count = user2.passive_relationships.count
    #   after_follower_count = user2.followers.count
    #   expect(before_rel_count).not_to eq after_rel_count
    #   expect(before_follower_count).not_to eq after_follower_count
    # end
  end
end
