require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Configuration do
  it "has default options" do
    config = Muddle::Configuration.new

    config.parse_with_premailer.should be_true
    config.insert_boilerplate_styles.should be_true
    config.insert_boilerplate_css.should be_true
    config.insert_boilerplate_attributes.should be_true
    config.validate_html.should be_true
    config.generate_plain_text.should be_false
    
    config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri
    })
  end

  it "accepts parameters at instantiation and sets options" do
    config = Muddle::Configuration.new(
      :parse_with_premailer => false,
      :insert_boilerplate_styles => false,
      :insert_boilerplate_css => false,
      :insert_boilerplate_attributes => false,
      :validate_html => false,
      :generate_plain_text => true,
      :premailer => {:line_length => 50}
    )

    config.parse_with_premailer.should be_false
    config.insert_boilerplate_styles.should be_false
    config.insert_boilerplate_css.should be_false
    config.insert_boilerplate_attributes.should be_false
    config.validate_html.should be_false
    config.generate_plain_text.should be_true
    config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri,
      :line_length => 50
    })
  end


  it "accepts a block at instantiation and sets options" do
    config = Muddle::Configuration.new do |config|
      config.parse_with_premailer = false
      config.insert_boilerplate_styles = false
      config.insert_boilerplate_css = false
      config.insert_boilerplate_attributes = false
      config.validate_html = false
      config.generate_plain_text = true
      config.premailer[:line_length] = 50
    end

    config.parse_with_premailer.should be_false
    config.insert_boilerplate_styles.should be_false
    config.insert_boilerplate_css.should be_false
    config.insert_boilerplate_attributes.should be_false
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
      config.insert_boilerplate_styles = false
      config.insert_boilerplate_css = false
      config.insert_boilerplate_attributes = false
      config.validate_html = false
      config.generate_plain_text = true
      config.premailer[:line_length] = 50
    end

    config.parse_with_premailer.should be_false
    config.insert_boilerplate_styles.should be_false
    config.insert_boilerplate_css.should be_false
    config.insert_boilerplate_attributes.should be_false
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
