require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: user) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }

  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "should respond to title" do
      expect(post).to respond_to(:title)
    end

    it "should respond to body" do
      expect(post).to respond_to(:body)
    end
  end

  describe "orders of posts" do
    it "orders by descending created_at date" do
      recent_first = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:00:00")
      recent_second = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:01:00")
      recent_third = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:02:00")
      recent_fourth = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:03:00")
      recent_fifth = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:04:00")
      recent_sixth = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:05:00")
      expect(Post.most_recent).to eq [recent_sixth, recent_fifth, recent_fourth, recent_third, recent_second]
    end
  end
end
