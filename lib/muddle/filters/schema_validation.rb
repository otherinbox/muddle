module Muddle::Filter::SchemaValidationFilter
  extend Muddle::Filter

  def self.filter(email_body)
    doc = as_nokogiri(email_body)

    if doc.internal_subset.nil?
      doc.create_internal_subset("html", "-//W3C//DTD XHTML 1.0 Strict//EN", "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd")
    end

    nokogiri_to_string( doc )
  end
end
