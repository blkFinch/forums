class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: ->{request.format.json? }

  before_action :logged_in_user

  include SessionsHelper
  include Response
  include ExceptionHandler

  # before_action :authorize_request
  # attr_reader :current_user


  private

    def logged_in_user
      unless logged_in?
        flash[:danger]  = "Please log in!"
        redirect_to login_url
      end
    end

    
end
