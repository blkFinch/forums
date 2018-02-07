class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(screen_name: params[:session][:screen_name])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'Successful Log in!'
      log_in user 
      redirect_to user
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
