# /time?format=year%2Cmonth%2Cday

class FormatTime
  TYPES = %w[year month day hour minute second]

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

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
    parsed_formats = format.map { |data| FORMATS[data] }.join('-')
    Time.now.strftime(parsed_formats)
  end
end
