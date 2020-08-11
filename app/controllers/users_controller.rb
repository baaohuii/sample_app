class UsersController < ApplicationController
  before_action :load_user, only: %i(edit update destroy)
  before_action :logged_in_user, only: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.sort_by_name.page params[:page]
  end

  def show
  	@user = User.find_by id: params[:id]
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      flash.now[:danger] = "Sorry. Please try again."
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      flash.now[:danger] = "Update failed."
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  
  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def logged_in_user
    return unless logged_in?
    
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end
  
  def load_user
    @user  = User.find_by id: params[:id]
    return if @user

    flash[:danger] = "Message"
    redirect_to root_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user? @user
  
    redirect_to root_url
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
 end
