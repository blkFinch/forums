class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers 
  end




  attr_reader :headers 

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

  rescue ActiveRecord::RecordNotFound => e 
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
      )
  end

  private 

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    Rails.logger.info headers
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end