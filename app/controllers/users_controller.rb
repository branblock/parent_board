class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_user, only: [:show, :destroy]

  def index
  end

  def show
  end

  def destroy
  end

  private
  def ready_user
    @user = User.find(params[:id])
  end

end
