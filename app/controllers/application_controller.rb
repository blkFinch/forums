class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Response
  include ExceptionHandler

  private

    def logged_in_user
      unless logged_in?
        flash[:danger]  = "Please log in!"
        redirect_to login_url
      end
    end

    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
end
