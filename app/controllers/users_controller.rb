class UsersController < ApplicationController
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
      flash[:danger] = "Danger! Please try again."
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  private
  
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
 end
