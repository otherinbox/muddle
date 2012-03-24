require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Configuration do
  it "has default options" do
    config = Muddle::Configuration.new

    config.parse_with_premailer.should be_true
    config.apply_email_boilerplate.should be_true
    config.validate_html.should be_true
    config.generate_plain_text.should be_false
    
    config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri
    })
  end

  it "accepts a block at instantiation and sets options" do
    config = Muddle::Configuration.new do |config|
      config.parse_with_premailer = false
      config.apply_email_boilerplate = false
      config.validate_html = false
      config.generate_plain_text = true
      config.premailer[:line_length] = 50
    end

    config.parse_with_premailer.should be_false
    config.apply_email_boilerplate.should be_false
    config.validate_html.should be_false
    config.generate_plain_text.should be_true
    config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri,
      :line_length => 50
    })
  end

  it "accepts a block to configure and sets options" do
    config = Muddle::Configuration.new
    config.configure do |config|
      config.parse_with_premailer = false
      config.apply_email_boilerplate = false
      config.validate_html = false
      config.generate_plain_text = true
      config.premailer[:line_length] = 50
    end

    config.parse_with_premailer.should be_false
    config.apply_email_boilerplate.should be_false
    config.validate_html.should be_false
    config.generate_plain_text.should be_true
    config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri,
      :line_length => 50
    })
  end

  it "allows direct assignment" do
    config = Muddle::Configuration.new
    config.parse_with_premailer = false
    config.parse_with_premailer.should be_false
  end

end
