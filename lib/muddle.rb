$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require "muddle/version"

require "muddle/filter"
require "muddle/parser"
require "muddle/configuration"
require 'muddle/logger'

module Muddle
  # Top-level configuration function
  #
  # Pass it a block and the configuration object will yield 'self'
  #
  def self.configure(&block)
    config.configure(&block)
  end

  def self.config
    @config ||= Muddle::Configuration.new
  end

  # Top-level parser function
  #
  # body_string should be an email body in string form
  #
  # returns body_string after passing it through the filters defined in Parser.filters
  #
  def self.parse(body_string)
    parser.parse body_string
  end

  def self.parser
    @parser ||= Muddle::Parser.new
  end
end
