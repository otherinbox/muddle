require 'hpricot'

module Muddle::Filter::BoilerplateStyleElement
  extend Muddle::Filter

  def self.filter(body_string)
    doc = Hpricot(body_string)

    insert_style_block(doc)

    doc.to_html
  end

  def self.insert_style_block(doc)
    find_or_append(doc, 'html', :with => '<html></html>') do |html|
      find_or_prepend(html.first, 'body', :with => '<body></body>') do |body|
        if node = body.search('style:first-of-type()').first
          node.before('<style type="text/css"></style>')
        else
          append_or_insert(body.first, '<style type="text/css"></style>')
        end

        body.search('style:first-of-type()').inner_html(boilerplate_css)
      end
    end
  end

  def self.boilerplate_css
    @boilerplate_css ||= File.read(File.join(File.dirname(__FILE__), '..', 'resources', 'boilerplate_style.css'))
  end
end
