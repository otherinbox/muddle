module Muddle
  class Parser
    attr_accessor :filters

    # Initialize the parser
    #
    # base is the parent muddle instance, and must be passed so the parser
    #     can access the parse settings
    #
    def initialize(config=Muddle.config)
      @filters = []

      @filters << Muddle::PremailerFilter if config.parse_with_premailer
      @filters << Muddle::EmailBoilerplateFilter if config.apply_email_boilerplate
      @filters << Muddle::SchemaValidationFilter if validate_html
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
end
