require 'hpricot'

module Muddle::Filter::BoilerplateCSS
  extend Muddle::Filter

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
    doc = Hpricot(body_string)

    insert_styles_to_inline(doc)

    doc.to_html
  end

  def self.insert_styles_to_inline(doc)
    find_or_append(doc, 'html', :with => '<html></html>') do |html|
      find_or_prepend(html.first, 'head', :with => '<head></head>') do |head|
        if node = head.search('style:first-of-type()').first
          node.before('<style type="text/css"></style>')
        else
          prepend_or_insert(head.first, '<style type="text/css"></style>')
        end
        
        head.search('style:first-of-type()').inner_html(boilerplate_css)
      end
    end
  end

  def self.boilerplate_css
    @boilerplate_css ||= File.read(File.join(File.dirname(__FILE__), '..', 'resources', 'boilerplate_inline.css'))
  end
end
