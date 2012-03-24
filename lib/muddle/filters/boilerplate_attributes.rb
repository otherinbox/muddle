require 'nokogiri'

module Muddle
  module BoilerplateAttributesFilter
    def self.filter(body_string)
      doc = Nokogiri::XML::DocumentFragment.parse(body_string)
      
      ensure_node_includes(doc, 'table', 'cellpadding', '0')
      ensure_node_includes(doc, 'table', 'cellspacing', '0')
      ensure_node_includes(doc, 'table', 'border', '0')
      ensure_node_includes(doc, 'table', 'align', 'center')

      ensure_node_includes(doc, 'td', 'valign', 'top')

      ensure_node_includes(doc, 'a', 'target', '_blank')

      doc.to_xhtml
    end

    def self.ensure_node_includes(doc, element_selector, attribute, default_value)
      doc.css("#{element_selector}:not([#{attribute}])").each do |node|
        node[attribute] = default_value
      end
    end
  end
end
