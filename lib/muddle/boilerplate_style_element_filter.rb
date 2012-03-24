require 'nokogiri'

module Muddle
  module BoilerplateStyleElementFilter
    def self.filter(body_string)
      doc = Nokogiri::XML::DocumentFragment.parse(body_string)
      
      insert_style_block(doc)

      doc.to_xhtml
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
