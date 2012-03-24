require 'nokogiri'

module Muddle
  module EmailBoilerplateFilter
    def self.filter(body_string)
      doc = Nokogiri::XML::DocumentFragment.parse(body_string)

      # body attributes
      ensure_style_includes(doc, 'body', 'width', '100% !important')
      ensure_style_includes(doc, 'body', '-webkit-text-size-adjustment', '100%')
      ensure_style_includes(doc, 'body', '-ms-text-size-adjustment', '100%')
      ensure_style_includes(doc, 'body', 'margin', '0')
      ensure_style_includes(doc, 'body', 'padding', '0')

      # img attributes
      ensure_style_includes(doc, 'img', 'outline', 'none')
      ensure_style_includes(doc, 'img', 'text-decoration', 'none')
      ensure_style_includes(doc, 'img', '-ms-interpolation-mode', 'bicubic')

      # a img attributes
      ensure_style_includes(doc, 'a img', 'border', 'none')

      # p attributes
      ensure_style_includes(doc, 'p', 'margin', '1em 0')

      # h attributes
      ensure_style_includes(doc, 'h1,h2,h3,h4,h5,h6', 'color', 'black !important')

      # h a attributes
      ensure_style_includes(doc, 'h1 a,h2 a,h3 a,h4 a,h5 a,h6 a', 'color', 'blue !important')

      # a attributes
      ensure_style_includes(doc, 'a', 'color', 'blue')

      insert_style_block(doc)

      doc.to_xhtml
    end

    def self.ensure_style_includes(doc, element_selector, css_attribute, default_value)
      doc.css("#{element_selector}:not([style*=#{css_attribute}])").each do |node|
        node['style'] = "#{node['style']} #{css_attribute}:#{default_value};"
      end
    end

    def self.insert_style_block(doc)
      doc.css("head").first do |head|
        if head.css("style")
          head.css("style").first.add_before('style').content(boilerplate_css)
        else
          head.add_child('style').content(boilerplate_css)
        end
      end
    end

    def self.boilerplate_css
      @boilerplate_css ||= File.read('email_boilerplate.css')
    end
  end
end
