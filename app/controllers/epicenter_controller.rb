class EpicenterController < ApplicationController

  before_action :set_user, only: [:show_user, :following, :followers, :feed]

  def feed
    following_user_ids = current_user.following + [current_user.id]
    @following_tweets = Tweet.where(user_id: following_user_ids)
    @tweet = Tweet.new

  end

  def show_user

  end

  def now_following
    current_user.update(following: current_user.following.push(params[:id].to_i))

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.update(following: current_user.following.delete(params[:id].to_i))
    redirect_to show_user_path(id: params[:id])
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def all_users
    @users = User.all
    # or:
    # User.order(:username)
    # User.order(:name)
    # or whatever order you'd
    # like to put them in
  end

  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end

  def set_user
    @user = User.find(params[:id] || current_user.id)
  end
end
