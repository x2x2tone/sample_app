require 'spec_helper'

describe Relationship do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        Relationship.new(follower_id: follower.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }

    its(:follower) { should == follower }
    its(:followed) { should == followed }
  end

  describe "invalid relationships" do
    let(:invalid_relationship) { }
    describe "followed_id is blank" do
      before { relationship.followed_id = nil }
      it { should_not be_valid }
    end

    describe "followed_id is blank" do
      before { relationship.follower_id = nil }
      it { should_not be_valid }
    end
  end
end
