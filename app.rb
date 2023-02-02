require_relative 'format_time'

class App
  attr_reader :status, :body

  def call(env)
    @request = Rack::Request.new(env)
    return response_handler if request_time?
    
    response(404, 'Not found')
  end

  private

  def request_time?
    @request.get? && @request.path == '/time' && @request.params['format']
  end

  def response(status, body)
    [status, { 'Content-Type' => 'text/plain' }, ["#{body}\n"]]
  end

  def response_handler
    format_time = FormatTime.new(@request)
    return response(200, format_time.parsed_formats) if format_time.format_valid?

    response(400, "Unknown time format: #{format_time.errors}")
  end
end
