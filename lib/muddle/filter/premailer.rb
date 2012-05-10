require 'premailer'

module Muddle::Filter::Premailer
  def self.filter(body_string)
    premailer = Premailer.new(body_string, Muddle.config.premailer_options)

    warn "Premailer generated #{premailer.warnings.length.to_s} warnings:" unless premailer.warnings.empty?

    premailer.warnings.each do |w|
      warn "#{w[:message]} (#{w[:level]}) may not render properly in #{w[:clients]}"
    end

    premailer.to_inline_css
  end
end
