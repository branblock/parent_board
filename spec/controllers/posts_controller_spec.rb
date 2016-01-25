require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:my_post) { FactoryGirl.create(:post, user: user) }

  context "all posts index" do
    login_user
    describe "GET index" do
      it "returns http success" do
        get :index
      expect(response).to have_http_status(:success)
      end

      it "assigns @posts to all posts" do
        get :index
        expect(assigns(:posts)).to eq([my_post])
      end
    end
  end

  context "with valid attributes" do
    let(:valid_post) { post :create, post: FactoryGirl.build(:post).attributes }
    login_user
    describe "POST create" do
      it "creates a new post" do
        expect { valid_post }.to change(Post, :count).by(1)
      end

      it "returns http status success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "with invalid attributes" do
    login_user
    it "does not create a new post" do
      expect {
        post :create, post: {title: "", body: ""}
      }.to_not change(Post, :count)
    end

    it "redirects to the #new view" do
      post :create, post: {title: "", body: ""}
      expect(response).to render_template :new
    end

  end

  describe "GET show" do
    login_user
    it "returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: my_post.id
      expect(response).to render_template :show
    end

    it "assigns post to @post" do
      get :show, id: my_post.id
      expect(assigns(:post)).to eq(my_post)
    end
  end

  describe "GET new" do
    login_user
    it "returns http status success" do
      get :new, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, id: my_post.id
      expect(response).to render_template :new
    end

    it "initializes @post" do
      get :new, id: my_post.id
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "GET edit" do
    login_user
    it "returns http success" do
      get :edit, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, id: my_post.id
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, {id: my_post}
      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  context "update post with valid attributes" do
    login_user
    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = "New Title"
        new_body = "New Body"

        put :update, id: my_post.id, post: {title: new_title, body: new_body}

        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = "New Title"
        new_body = "New Body"

        put :update, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_post]
        expect(flash[:notice]).to be_present
      end
    end
  end

  context "try to update post with invalid attributes" do
    login_user
    it "renders to the #edit view" do
      put :update, id: my_post.id, post: {title: "", body: ""}
      expect(response).to render_template :edit
    end
  end

  context "user deleting post" do
    login_user
    describe "DELETE destroy" do
      it "destroys the post" do
        delete :destroy, id: my_post.id
        count = Post.where({id: my_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to posts index" do
        delete :destroy, {id: my_post.id}
        expect(response).to redirect_to posts_path
        expect(flash[:notice]).to be_present
      end
    end
  end

end
