require 'rails_helper'

RSpec.describe BookmarksController, type: :controller, focus: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:my_post) { FactoryGirl.create(:post, user: user) }

  describe 'POST create' do
    login_user
    it "returns http success" do
      post :create, format: :js, post_id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it 'creates a bookmark for the current user and specified post' do
      expect(user.bookmarks.find_by_post_id(my_post.id)).to be_nil
      FactoryGirl.create(:bookmark, post: my_post, user: user)
      expect(user.bookmarks.find_by_post_id(my_post.id)).not_to be_nil
    end
  end

  describe 'DELETE destroy' do
    let(:bookmark) { FactoryGirl.create(:bookmark, post: my_post) }
    login_user
    it "returns http success" do
      delete :destroy, {post_id: my_post.id, id: bookmark.id}
      expect(response).to have_http_status(:success)
    end

    it 'destroys the bookmark for the current user and post' do
      expect(user.bookmarks.find_by_post_id(my_post.id)).not_to be_nil
      delete :destroy, format: :js, post_id: my_post.id, id: bookmark.id
      expect(user.bookmarks.find_by_post_id(my_post.id)).to be_nil
    end
  end
end
