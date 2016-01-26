class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @new_comment = Comment.new

    @comment.save

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    flash.now[:notice] = "Comment was deleted."

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
