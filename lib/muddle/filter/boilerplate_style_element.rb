require 'nokogiri'

module Muddle::Filter::BoilerplateStyleElement
  def self.filter(body_string)
    doc = Nokogiri::XML(body_string)

    insert_style_block(doc)

    doc.to_xhtml
  end

  def self.insert_style_block(doc)
    if style_node = doc.css("body style").first
      style_node.add_previous_sibling('<style type="text/css"></style>').first.content = boilerplate_css
    elsif body_node = doc.css("body").first
      body_node.add_child('<style type="text/css"></style>').first.content = boilerplate_css
    end
  end

  def self.boilerplate_css
    @boilerplate_css ||= File.read(File.join(File.dirname(__FILE__), '..', 'resources', 'boilerplate_style.css'))
  end
end
