require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:my_post) { FactoryGirl.create(:post, user: user) }
  let(:comment) { FactoryGirl.create(:comment, post: my_post) }

  it { should belong_to(:user) }
  it { should belong_to(:post) }

  it { should validate_presence_of(:body) }

  it { should validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "should respond to body" do
      expect(post).to respond_to(:body)
    end
  end

end
