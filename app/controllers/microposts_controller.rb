class MicropostsController < ApplicationController
  before_action :check_login, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build create_micropost_params
    @micropost.image.attach create_micropost_params[:image]
    if @micropost.save
      flash[:success] = t "microposts.create_success"
      redirect_to root_path
    else
      flash.now[:warning] = t "microposts.create_fail"
      @feed = current_user.feed.recent_posts.paginate page: params[:page]
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "microposts.delete_success"
    else
      flash[:warning] = t "microposts.delete_fail"
    end
    redirect_to request.referer || root_path
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "sessions.incorrect_user"
    redirect_to root_path
  end

  def check_login
    return if logged_in

    store_location
    flash[:warning] = t "sessions.not_login"
    redirect_to login_path
  end

  def create_micropost_params
    params.require(:micropost).permit :content, :image
  end
end
