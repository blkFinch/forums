class AuthenticationController < ApplicationController
  def authenticate
    auth_token = 
      AuthenticateUser.new(auto_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
