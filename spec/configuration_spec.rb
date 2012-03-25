require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Configuration do
  it "sets default options" do
    config = Muddle::Configuration.new

    config.parse_with_premailer.should be_true
    config.apply_email_boilerplate.should be_true
    config.validate_html.should be_true
    config.generate_plain_text.should be_false
  end


  it "accepts a block and updates options" do
    config = Muddle::Configuration.new do |config|
      config.parse_with_premailer = false
      config.apply_email_boilerplate = false
      config.validate_html = false
      config.generate_plain_text = true
    end

    config.parse_with_premailer.should be_false
    config.apply_email_boilerplate.should be_false
    config.validate_html.should be_false
    config.generate_plain_text.should be_true
  end

  it "generates a default configuration on the base object" do
    muddler = Muddle::Base.new

    muddler.config.parse_with_premailer.should be_true
    muddler.config.apply_email_boilerplate.should be_true
    muddler.config.validate_html.should be_true
    muddler.config.generate_plain_text.should be_false
  end

  it "constructs the base object with a configure method" do
    muddler = Muddle::Base.new
    muddler.configure do |config|
      config.parse_with_premailer = false
      config.apply_email_boilerplate = false
      config.validate_html = false
      config.generate_plain_text = true
    end

    muddler.config.parse_with_premailer.should be_false
    muddler.config.apply_email_boilerplate.should be_false
    muddler.config.validate_html.should be_false
    muddler.config.generate_plain_text.should be_true
  end

  it "accepts a confiig block at creation of the base object" do
    muddler = Muddle::Base.new do |config|
      config.parse_with_premailer = false
      config.apply_email_boilerplate = false
      config.validate_html = false
      config.generate_plain_text = true
    end

    muddler.config.parse_with_premailer.should be_false
    muddler.config.apply_email_boilerplate.should be_false
    muddler.config.validate_html.should be_false
    muddler.config.generate_plain_text.should be_true
  end
end
