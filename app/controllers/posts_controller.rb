class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.most_recent
    if params[:tag].present?
      @tagged_posts = @posts.tagged_with(params[:tag])
    else
      @posts
    end
  end

  def show
    @user = @post.user(params[:id])
    @current_user = current_user
  end

  def new
    @post = Post.new
    @post.user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post has been saved."
      redirect_to [@post]
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)

    if @post.save
      flash[:notice] = "Post has been updated."
      redirect_to [@post]
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been deleted."
    redirect_to action: :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def ready_post
    @post = Post.find(params[:id])
  end

end
