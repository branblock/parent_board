class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post

  def create
    bookmark = current_user.bookmarks.build(post: @post)
    bookmark.save

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    bookmark = current_user.bookmarks.find(params[:id])
    bookmark.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private
  def ready_post
    @post = Post.find(params[:post_id])
  end
end
