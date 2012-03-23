class Muddle::Interceptor
  def self.delivering_email(message)
    new(message).muddle_message
  end

  def initialize(message)
    @message = message
  end

  def muddle_message
    return @message unless html_found?

    new_message_body = Muddle::Parser.parse(message_body)
    replace_message_body(new_message_body)
    @message
  end

  def html_found?
    body_location.content_type =~ /text\/html/
  end

  def message_body
    @message_body ||= find_message_body
  end

  def find_message_body
    body_location.body
  end

  def body_location
    @body_location ||= @message.html_part || @message
  end

  def replace_message_body(new_message_body)
    body_location.body = new_message_body
  end
end
