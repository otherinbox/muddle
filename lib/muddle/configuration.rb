module Muddle
  class Configuration
    attr_accessor :parse_with_premailer
    attr_accessor :apply_email_boilerplate
    attr_accessor :validate_html
    attr_accessor :generate_plain_text

    def initialize(&block)
      @parse_with_premailer = true
      @apply_email_boilerplate = true
      @validate_html = true
      @generate_plain_text = false

      if block_given?
        configure &block
      end
    end

    def configure
      yield self
    end
  end
end
