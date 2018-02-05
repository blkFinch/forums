class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.permission = 1;
    if @user.save
      flash[:success] = "Welcome to the forums!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :screen_name, :password, :password_confirmation, 
                                  :email, :permission)
    end

end
