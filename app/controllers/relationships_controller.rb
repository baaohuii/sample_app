class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: %i(create index)

  def index
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
    @title = t ".#{params[:type]}"
    @users = @user.send(params[:type]).page params[:page]
    render "users/show_follow"
  end

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]
    if relationship.present?
      @user = relationship.followed
      current_user.unfollow @user
    else
      @error = t "follow.action_fail"
    end
    respond_to :js
  end
end
