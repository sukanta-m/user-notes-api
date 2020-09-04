module ControllerHelpers
  def response_parse(response)
    JSON.parse(response.body)
  end
end