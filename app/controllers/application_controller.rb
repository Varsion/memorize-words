class ApplicationController < ActionController::API
  include ErrorHandler

  before_action :set_default_response_format

  private

  def set_default_response_format
    request.format = :json
  end
end
