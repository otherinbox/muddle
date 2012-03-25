require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle do
  it "should define the logger method to access a global Logger instance" do
    Muddle.should respond_to(:logger)
    Muddle.logger.should be_an_instance_of(Logger)
    Muddle.logger.object_id.should == @logger.object_id
  end

  it "has a parser object" do
    Muddle.parser.should be_a(Muddle::Parser)
  end

  it "parses" do
    Muddle.parse("A string").should be_true
  end

  it "has a config with default options" do
    Muddle.config.parse_with_premailer.should be_true
    Muddle.config.insert_boilerplate_css.should be_true
    Muddle.config.validate_html.should be_true
    Muddle.config.generate_plain_text.should be_false
    Muddle.config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri
    })
  end
  
  it "constructs the root module with a configure method" do
    Muddle.configure do |config|
      config.parse_with_premailer = false
      config.insert_boilerplate_css = false
      config.validate_html = false
      config.generate_plain_text = true
      config.premailer[:line_length] = 50
    end

    Muddle.config.parse_with_premailer.should be_false
    Muddle.config.insert_boilerplate_css.should be_false
    Muddle.config.validate_html.should be_false
    Muddle.config.generate_plain_text.should be_true
    Muddle.config.premailer.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri,
      :line_length => 50
    })
  end
end
