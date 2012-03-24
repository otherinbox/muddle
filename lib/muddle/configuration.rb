module Muddle
  class Configuration
    attr_accessor :parse_with_premailer
    attr_accessor :insert_boilerplate_styles
    attr_accessor :apply_email_boilerplate
    attr_accessor :validate_html
    attr_accessor :generate_plain_text
    
    attr_accessor :premailer

    # Initialize the configuration object with default values
    #
    # if a block is passed, we'll yield 'this' to it so you can set config values
    #     
    def initialize(&block)
      @parse_with_premailer = true
      @insert_boilerplate_styles = true
      @apply_email_boilerplate = true
      @validate_html = true
      @generate_plain_text = false

      # NOTE: when this tries to inline CSS, all it sees is a stylesheet URL
      # This may require that we download css from the interwebs @ each render 
      # pass of a mailer ?!?!?
      @premailer = {
        #:base_url => root_url, # Put in rails stuff...
        :remove_comments => true, # Env-dependent?
        :with_html_string => true,
        :adapter => :nokogiri
      }

      if block_given?
        configure &block
      end
    end

    # Set config vars
    #
    # Pass it a block, will yield the config object
    #
    def configure
      yield self
    end
  end
end
