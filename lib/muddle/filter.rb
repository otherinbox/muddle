require 'nokogiri'

module Muddle::Filter
  def as_string(email_body)
    if email_body.kind_of? Nokogiri::XML::Node
      nokogiri_to_string email_body
    else
      email_body
    end
  end

  def as_nokogiri(email_body)
    if email_body.kind_of? Nokogiri::XML::Node
      email_body
    else
      string_to_nokogiri( email_body )
    end
  end

  def nokogiri_to_string(node)
    node.to_xhtml
  end

  def string_to_nokogiri(string)
    Nokogiri::XML(string)
  end

  require "muddle/filters/premailer"
  require "muddle/filters/boilerplate_style_element"
  require "muddle/filters/boilerplate_css"
  require "muddle/filters/boilerplate_attributes"
  require "muddle/filters/schema_validation"
end
