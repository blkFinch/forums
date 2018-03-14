class SessionsController < ApplicationController
  skip_before_action :logged_in_user, except: :destroy

  def new
  end

  def create
    user = User.find_by(screen_name: params[:session][:screen_name])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'Successful Log in!'
      log_in user 
      redirect_to root_path
    else
      flash[:danger] = 'Invalid Screen Name / Password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
