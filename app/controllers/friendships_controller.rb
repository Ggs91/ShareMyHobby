class FriendshipsController < ApplicationController
  before_action :authenticate_user! # Only registered users can follow someone
  before_action :find_user # lookinf for the user to differentiate the current_user and the user he/she follows

  def create # follow a user
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def destroy # Unfollowa user
    current_user.unfollow(@user)
    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
