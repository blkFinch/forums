module SessionsHelper
  def log_in(user = nil)
    if(user)
      session[:user_id] = user.id
    elsif(headers.authorization_token)
      log_in_with_token()
    else
      return false 
    end
  end

  def log_in_with_token()
  end

  def current_user
    @current_cuser ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
