class FormatTime
  TYPES = %w[year month day hour minute second]

  attr_reader :errors

  def initialize(params)
    @parsed_query_string = params['format'].split(',')
    @errors = @parsed_query_string - TYPES
  end

  def parsed_formats
    @parsed_formats ||= parse_formats(@parsed_query_string)
  end

  def format_valid?
    @errors.empty?
  end

  private

  def parse_formats(format)
    parsed_formats = format.map do |t|
      Time.now.public_send(t.to_sym)
    end
    parsed_formats.join('-')
  end
end
