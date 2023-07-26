module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from(JWT::DecodeError, UnauthorizedException) { |err| handle_401(err: err) }
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
    handle_error(status: 422, fields: fields, message: message || "参数不合法")
  end

  def handle_401(err: nil)
    handle_error(status: 401, err: err, message: "用户权限校验失败")
  end

  def handle_404(fields:, model:)
    handle_error(status: 404, fields: fields, message: "#{model} Not Found")
  end

  def handle_ok(message: "success")
    render plain: { message: message }.to_json, status: 200
  end
end
