module ErrorHandler
  extended ActiveSupport::Concern

  # params error
  def handle_422(message: nil, fields:)
    fields = Array.wrap(fields)
    render json: {
             message: message || "参数不合法",
             fields: fields,
           },
           status: 422
  end
end
