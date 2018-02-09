class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :is_admin, only: [:index]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.by_time
    @article = current_user.articles.build if logged_in?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.permission = 1;
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the forums!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:sucess] = "Profile Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end


  private
    def user_params
      params.require(:user).permit(:name, :screen_name, :password, :password_confirmation, 
                                  :email, :permission)
    end

    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user || current_user.permission >= 3
        flash[:danger] = "Not Authorized!"
        redirect_to(root_url)
      end
    end

    def is_admin
      unless current_user.permission >= 3
        flash[:danger] = "Not Authorized!"
        redirect_to(root_url)
      end
    end
end
