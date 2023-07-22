errors = []

@record.errors.collect do |error|
  errors << {
    attribute: error.attribute.to_s,
    message: error.message,
  }
end

json.fields errors do |error|
  json.attribute error[:attribute]
  json.message error[:message]
end
