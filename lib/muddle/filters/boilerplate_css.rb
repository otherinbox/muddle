require 'nokogiri'

module Muddle
  module BoilerplateCSSFilter
    # Boilerplate CSS Filter
    #
    # Inserts a style tag containing the boilerplate CSS - we assume that this will
    # later be filtered with the Premailer filter and inlined at that time.  
    #
    # If the body_string doesn't look like an HTML file, we'll build as much structure
    # as makes sense in the context of a style tag (ie at least enclosing <html> and <head> tags)
    #
    # The style tag will be inserted before any existing style tags so that any user-supplied
    # CSS will over-write our boilerplate stuff
    #
    def self.filter(body_string)
      doc = Nokogiri::HTML(body_string)

      if style_node = doc.xpath('//head/style').first
        add_style_tag_before(style_node)
      elsif head_node = doc.xpath('//head').first
        add_style_tag_to(head_node)
      elsif html_node = doc.xpath('html').first
        head_node = html_node.add_child('<head></head>').first
        add_style_tag_to(head_node) 
      else
        raise "HTML Parsing error - <html> element not found"
      end

      doc.to_xhtml
    end

    # Insert the style tag before the passed node
    #
    def self.add_style_tag_before(style_node)
      new_style_node = style_node.add_previous_sibling('<style type="text/css"></style>').first
      build_style_tag_with(new_style_node)
    end

    # Insert the style tag as a child of the passed node
    #
    def self.add_style_tag_to(head_node)
      if first_child = head_node.first_element_child
        add_style_tag_before(first_child)
      else
        style_node = head_node.add_child('<style type="text/css"></style>').first
        build_style_tag_with(style_node)
      end
    end

    # Insert the CSS content
    #
    def self.build_style_tag_with(style_node)
      style_node.content = boilerplate_css
    end

    def self.boilerplate_css
      @boilerplate_css ||= File.read(File.join(File.dirname(__FILE__), '..', 'resources', 'boilerplate_inline.css'))
    end
  end
end
