class ApplicationController < ActionController::API
  include ErrorHandler

  before_action :set_default_response_format

  def authenticate_user!
    raise UnauthorizedException.new unless set_current_user && @current_user
  end

  private

  def set_current_user
    token = request.headers["Authorization"]
    data = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
    @current_user = User.find_by(id: data["user_id"])
  end

  def set_default_response_format
    request.format = :json
  end
end
