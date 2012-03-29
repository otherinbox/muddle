class Muddle::Parser
  attr_accessor :filters

  def initialize
    @filters = []

    @filters << Muddle::Filter::BoilerplateCSSFilter if Muddle.config.insert_boilerplate_css
    @filters << Muddle::Filter::PremailerFilter if Muddle.config.parse_with_premailer
    @filters << Muddle::Filter::BoilerplateStyleElementFilter if Muddle.config.insert_boilerplate_styles
    @filters << Muddle::Filter::BoilerplateAttributesFilter if Muddle.config.insert_boilerplate_attributes
    @filters << Muddle::Filter::SchemaValidationFilter if Muddle.config.validate_html
  end

  # Parse an email body
  #
  # body_string is the email body to be parsed in string form
  #
  # Returns the parsed body string
  #
  def parse(body_string)
    filters.inject(body_string) {|filtered_string, filter| filter.filter(filtered_string)}
  end
end
