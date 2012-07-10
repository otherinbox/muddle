$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'resources'))

require 'muddle'

require 'mail'
require 'pry'
require 'logger'

RSpec.configure do |config|
  config.before(:each) do
    # Reset global state - probably a better way to do this?
    Muddle.config.send :initialize
    Muddle.parser.send :initialize

    # Set up logging
    @log = StringIO.new
    @logger = Logger.new @log

    # NOTE: I'm sure there's a better way to do this
    # based on https://gist.github.com/1057540
    Muddle.send(:class_variable_set, :@@logger, @logger)
  end

  def log
    @log.string
  end
end

RSpec::Matchers.define :have_xpath do |attribute|
  match do |model|
    !Nokogiri::HTML(model).xpath(attribute).empty?
  end
end

def xpath(string, selector)
  Nokogiri::HTML(string).xpath(selector)
end

def multi_part_email
  Mail.new do
    to 'you@you.com'
    from 'me@me.com'
    subject 'Better emails in Ruby'

    html_part do
      content_type 'text/html; charset=UTF-8'
      body '<html><body><h1>Muddle is awesome!</h1></body></html>'
    end

    text_part do
      body 'Muddle is pretty cool.'
    end
  end
end

def html_email
  Mail.new do
    to 'you@you.com'
    from 'me@me.com'
    subject 'Better emails in Ruby'
    content_type 'text/html; charset=UTF-8'
    body '<html><body><h1>Muddle is awesome!</h1></body></html>'
  end
end

def plaintext_email
  Mail.new do
    to 'you@you.com'
    from 'me@me.com'
    subject 'Better emails in Ruby'
    body 'Muddle is pretty cool.'
  end
end

def minimal_email_body
  File.read(File.join(File.dirname(__FILE__), 'resources', 'minimal_email.html'))
end

def example_email_body
  File.read(File.join(File.dirname(__FILE__), 'resources', 'example_email.html'))
end

def email_body_with_dtd
  File.read(File.join(File.dirname(__FILE__), 'resources', 'dtd_email.html'))
end

def email_body_with_custom_dtd
  File.read(File.join(File.dirname(__FILE__), 'resources', 'custom_dtd_email.html'))
end

def html5_email
  File.read(File.join(File.dirname(__FILE__), 'resources', 'html5_email.html'))
end

def reset_muddle_module
  %W(@config @parser).each do |var|
    Muddle.instance_variable_set(var, nil)
  end
end
