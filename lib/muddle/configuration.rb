class Muddle::Configuration
  attr_accessor :parse_with_premailer
  attr_accessor :insert_boilerplate_styles
  attr_accessor :insert_boilerplate_css
  attr_accessor :insert_boilerplate_attributes
  attr_accessor :validate_html
  attr_accessor :generate_plain_text

  attr_accessor :premailer_options

  # Initialize the configuration object with default values
  #
  # if a block is passed, we'll yield 'this' to it so you can set config values
  #
  def initialize(options = {}, &block)
    @parse_with_premailer = options[:parse_with_premailer] || true
    @insert_boilerplate_styles = options[:insert_boilerplate_styles] || true
    @insert_boilerplate_css = options[:insert_boilerplate_css] || true
    @insert_boilerplate_attributes = options[:insert_boilerplate_attributes] || true
    @validate_html = options[:validate_html] || true
    @generate_plain_text = options[:generate_plain_text] || false

    # NOTE: when this tries to inline CSS, all it sees is a stylesheet URL
    # This may require that we download css from the interwebs @ each render
    # pass of a mailer ?!?!?
    @premailer_options = {
      #:base_url => root_url, # Put in rails stuff...
      :remove_comments => true, # Env-dependent?
      :with_html_string => true,
      :adapter => :hpricot
    }
  end

  # Set config vars
  #
  # Pass it a block, will yield the config object
  #
  def configure
    yield self
  end
end
