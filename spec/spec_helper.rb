$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'muddle'
require 'muddle/interceptor'

require 'mail'
require 'pry'

RSpec.configure do |config|
  config.before(:each) do
    # Reset global state - probably a better way to do this?
    Muddle.config.send :initialize
    Muddle.parser.send :initialize
  end
end

RSpec::Matchers.define :have_css do |attribute|
  match do |model|
    Nokogiri::XML::DocumentFragment.parse(model).css(attribute).empty?
  end
end

RSpec::Matchers.define :have_xpath do |attribute|
  match do |model|
    Nokogiri::XML::DocumentFragment.parse(model).xpath(attribute).empty?
  end
end

def multi_part_email
  Mail.new do
    to 'you@you.com'
    from 'me@me.com'
    subject 'Better emails in Rails'

    html_part do
      content_type 'text/html; charset=UTF-8'
      body '<h1>Muddle is awesome!</h1>'
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
    subject 'Better emails in Rails'
    content_type 'text/html; charset=UTF-8'
    body '<h1>Muddle is awesome!</h1>'
  end
end

def plaintext_email
  Mail.new do
    to 'you@you.com'
    from 'me@me.com'
    subject 'Better emails in Rails'
    body 'Muddle is pretty cool.'
  end
end
