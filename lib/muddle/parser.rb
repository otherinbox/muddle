class Muddle::Parser
  attr_accessor :filters

  # Set up the parser
  #
  # The default filters do the following:
  #
  # CSS  adds a style block containing boilerplate CSS attributes to be
  #   inlined.  This is based on Email Boilerplate's 'Inline: YES' portions
  #
  # Premailer passes the email through the Premailer gem, which inlines the CSS
  #   it can, then appends a style block to the body containing the rest (since
  #   some email clients strip out the <head> tag).
  #
  # Style Element adds another style block, but this one is intended to be left
  #   as a style declaration (rather than being inlined).  This is based on 
  #   EMail Boilerplate's 'Inline: NO' portions
  #
  # Attributes adds attributes to HTML elements where helpful, such as table cellpadding
  #   and such.  Based on Email Boilerplate's example element declarations
  #
  # Schema Validation currently just adds the XHTML Strict DTD and outputs to a string,
  #   however it's intended that this will eventually validate against an XSD and emit
  #   warnings about potentially troublesome tags (like <div>)
  #
  def initialize
    @filters = []

    @filters << Muddle::Filter::BoilerplateCSS          if Muddle.config.insert_boilerplate_css
    @filters << Muddle::Filter::Premailer               if Muddle.config.parse_with_premailer
    @filters << Muddle::Filter::BoilerplateStyleElement if Muddle.config.insert_boilerplate_styles
    @filters << Muddle::Filter::BoilerplateAttributes   if Muddle.config.insert_boilerplate_attributes
    @filters << Muddle::Filter::SchemaValidation        if Muddle.config.validate_html
  end

  # Parse an email body
  #
  # body_string is the email body to be parsed in string form
  #
  # Returns the parsed body string
  #
  def parse(body_string)
    filters.inject(body_string) do |filtered_string, filter|
      s = filter.filter(filtered_string)
    end
  end
end
