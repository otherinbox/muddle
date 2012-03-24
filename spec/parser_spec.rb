require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Parser do
  it "has a default set of filters" do
    pr = Muddle::Parser.new

    pr.filters.size.should eql(5)
    pr.filters[0].should eql(Muddle::PremailerFilter)
    pr.filters[1].should eql(Muddle::BoilerplateStyleElementFilter)
    pr.filters[2].should eql(Muddle::BoilerplateCSSFilter)
    pr.filters[3].should eql(Muddle::BoilerplateAttributesFilter)
    pr.filters[4].should eql(Muddle::SchemaValidationFilter)
  end

  it "only adds filters if config says" do
    Muddle.config.parse_with_premailer = false
    Muddle::Parser.new.filters.should_not include(Muddle::PremailerFilter)

    Muddle.config.insert_boilerplate_styles = false
    Muddle::Parser.new.filters.should_not include(Muddle::BoilerplateStyleElementFilter)

    Muddle.config.insert_boilerplate_css = false
    Muddle::Parser.new.filters.should_not include(Muddle::BoilerplateCSSFilter)

    Muddle.config.insert_boilerplate_attributes = false
    Muddle::Parser.new.filters.should_not include(Muddle::BoilerplateAttributesFilter)

    Muddle.config.validate_html = false
    Muddle::Parser.new.filters.should_not include(Muddle::SchemaValidationFilter)
  end

  context "with single parser enabled" do
    before(:each) do
      Muddle.configure do |config|
        config.parse_with_premailer = false
        config.insert_boilerplate_styles = false
        config.insert_boilerplate_css = false
        config.insert_boilerplate_attributes = false
        config.validate_html = false
      end
    end

    it "parses with premailer" do
      Muddle.config.parse_with_premailer = true
      result = Muddle::Parser.new.parse("A String")

      result.should be_true
      result.should be_a(String)
    end

    it "parses with email boilerplate"

    it "parses with schema validation"
  end
end
