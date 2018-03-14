module SessionsHelper
  def log_in(user = nil)
    if(user)
      session[:user_id] = user.id
    end
  end

  def log_in_with_token()
    AuthorizeApiRequest(request.headers)

  end

  def current_user
    @current_user ||= found_user
  end

  def found_user
    if(session[:user_id])
      User.find_by(id: session[:user_id])
    elsif(request.headers['Authorization'].present?)
      AuthorizeApiRequest.new(request.headers).user
    end
  end


  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
