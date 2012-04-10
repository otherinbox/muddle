module Muddle::Filter
  # Prepend the content if child nodes exist, otherwise insert it
  #
  def prepend_or_insert(doc, content)
    unless doc.empty?
      doc.children.first.before(content)
    else
      doc.inner_html(content)
    end
  end

  # Append the content if child nodes exist, otherwise insert it
  #
  def append_or_insert(doc, content)
    unless doc.empty?
      doc.children.last.after(content)
    else
      doc.inner_html(content)
    end
  end


  # Find `selector` within `doc`.  If not found, create using `with` as the 
  # last child of `doc`
  #
  def find_or_append(doc, selector, opts, &block)
    append_or_insert(doc, opts[:with]) if doc.search(selector).empty?
    yield doc.search(selector)
  end

  # Find `selector` within `doc` if not found, create using `with` as the
  # first child of `doc`
  #
  # yields to `block` and passes the found/created element
  #
  def find_or_prepend(doc, selector, opts, &block)
    prepend_or_insert(doc, opts[:with]) if doc.search(selector).empty?
    yield doc.search(selector)
  end

  # Insert content before `selector` within `doc` if the selector matches.  If
  # it doesn't match, add the block as the first child of `doc`
  #
  # yields to block and returns
  def before_or_prepend(doc, selector, &block)
    if node = doc.search(selector)
      node.before( block.call )
    else
      doc.prepend( block.call )
    end
  end
end

require 'muddle/filter/boilerplate_attributes'
require 'muddle/filter/boilerplate_css'
require 'muddle/filter/boilerplate_style_element'
require 'muddle/filter/premailer'
require 'muddle/filter/schema_validation'
