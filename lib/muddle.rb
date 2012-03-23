$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require "muddle/version"

require "muddle/premailer_filter"
require "muddle/email_boilerplate_filter"
require "muddle/schema_validation_filter"
require "muddle/parser"
require "muddle/configuration"

module Muddle
  # Top-level configuration function
  #
  # Pass it a block and the configuration object will yield 'self'
  #
  def configure(&block)
    yield config
  end

  def config
    @config ||= Muddle::Configuration.new
  end

  # Top-level parser function
  #
  # body_string should be an email body in string form
  #
  # returns body_string after passing it through the filters defined in Parser.filters
  #
  def parse(body_string)
    parser.parse body_string
  end

  def parser
    @parser ||= Muddle::Parser.new
  end

  # Wrapper for premailer's plaintext extraction
  #
  def plain_text_from(body_string)
  end
end
