require 'rails_helper'

RSpec.describe CommentsController, type: :controller, focus: true do
  let(:my_post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment, post: my_post) }


  context "with valid params" do
    let(:valid_comment) { post :create, format: :js, post_id: my_post.id, comment: FactoryGirl.build(:comment).attributes }
    login_user
    describe "POST create" do
      it "creates a new comment" do
        expect { valid_comment }.to change(Comment, :count).by(1)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "with invalid params" do
    let(:subject_comment) { post :create, format: :js, post_id: my_post.id, comment: { body: "" } }
    login_user
    describe "POST create" do
      it "does not create a new comment" do
        expect { subject_comment }.to_not change(Comment, :count)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "user deleting comment" do
    login_user
    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, format: :js, post_id: my_post.id, id: comment.id
        count = Comment.where({id: comment.id}).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, format: :js, post_id: my_post.id, id: comment.id
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to be_present
      end
    end
  end

end
