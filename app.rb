require_relative 'format_time'

class App
  def call(env)
    @request = Rack::Request.new(env)

    response_handler
    [status, {}, body]
  end

  private

  def response_handler
    return invalid_response if @request.path_info != '/time' || @request.query_string.empty?

    @format_time = FormatTime.new(@request)
    @format_time.format_valid? ? valid_format_response : invalid_format_response
  end

  attr_reader :status

  def body
    [@content]
  end

  def valid_format_response
    @status = 200
    @content = @format_time.parsed_formats
  end

  def invalid_format_response
    @status = 400
    @content = "Unknown time format: #{@format_time.errors}"
  end

  def invalid_response
    @status = 404
    @content = "Not found."
  end
end
