module Muddle
  module SchemaValidationFilter
    def self.filter(body_string)
      doc = Nokogiri::HTML(body_string)

      doc.serialize
    end
  end
end
