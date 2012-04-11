require 'hpricot'

module Muddle::Filter::BoilerplateAttributes
  def self.filter(body_string)
    doc = Hpricot(body_string)

    ensure_node_includes(doc, 'table', 'cellpadding', '0')
    ensure_node_includes(doc, 'table', 'cellspacing', '0')
    ensure_node_includes(doc, 'table', 'border', '0')
    ensure_node_includes(doc, 'table', 'align', 'center')

    ensure_node_includes(doc, 'td', 'valign', 'top')

    ensure_node_includes(doc, 'a', 'target', '_blank')

    doc.to_html
  end

  def self.ensure_node_includes(doc, element_selector, attribute, default_value)
    doc.search("#{element_selector}:not([@#{attribute}])").each do |node|
      node.attributes[attribute] = default_value
    end
  end
end
