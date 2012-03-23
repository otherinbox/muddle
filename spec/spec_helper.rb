$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'muddle'
require 'muddle/interceptor'

require 'mail'
require 'pry'

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
