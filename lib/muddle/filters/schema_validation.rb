module Muddle
  module SchemaValidationFilter
    def self.filter(body_string)
      doc = Nokogiri::XML(body_string)

      if doc.internal_subset.nil?
        doc.create_internal_subset("html", "-//W3C//DTD XHTML 1.0 Strict//EN", "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd")
      end

      doc.to_xhtml
    end
  end
end
