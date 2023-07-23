module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from(JWT::DecodeError, UnauthorizedException) { |err| handler_401(err: err) }
  end

  def handle_error(status:, err: nil, message: nil, fields: nil)
    if err.is_a?(Exception)
      message ||= err.message
      fields ||= err.class
    end
    fields = Array.wrap(fields)
    render json: {
      message: message || "系统错误",
      fields: fields,
    }, status: status
  end

  # params error
  def handle_422(message: nil, fields:)
    handler_error(status: 422, fields: fields, message: message || "参数不合法")
  end

  def handler_401(err:)
    handle_error(status: 401, err: err, message: "用户权限校验失败")
  end
end
