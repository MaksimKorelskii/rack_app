require 'logger'

class AppLogger
  attr_reader :query_string

  def initialize(app, **options)
    @app = app
    @logger = Logger.new(options[:logdev])
  end

  def call(env)
    @logger.info(env)
    @app.call(env)
  end
end
