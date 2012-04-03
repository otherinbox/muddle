require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle do
  it "has a parser object" do
    Muddle.parser.should be_a(Muddle::Parser)
  end

  context "with default options" do
    it "uses premailer" do
      Muddle.config.parse_with_premailer.should be_true
    end

    it "inserts boiletplate css" do
      Muddle.config.insert_boilerplate_css.should be_true
    end

    it "validates the html" do
      Muddle.config.validate_html.should be_true
    end

    it "doesn't generate plaintext" do
      Muddle.config.generate_plain_text.should be_false
    end

    it "configures premailer to remove comments" do
      Muddle.config.premailer[:remove_comments].should be_true
    end

    it "configures premailer to expect input as a string" do
      Muddle.config.premailer[:with_html_string].should be_true
    end

    it "configures premailer to use hpricot" do
      Muddle.config.premailer[:adapter].should == :hpricot
    end
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
      :adapter => :hpricot,
      :line_length => 50
    })
  end
end
