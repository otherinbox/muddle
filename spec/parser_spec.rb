require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Parser do
  it "has a default set of filters" do
    pr = Muddle::Parser.new

    pr.filters.size.should eql(5)
    pr.filters[0].should eql(Muddle::BoilerplateCSSFilter)
    pr.filters[1].should eql(Muddle::PremailerFilter)
    pr.filters[2].should eql(Muddle::BoilerplateStyleElementFilter)
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

  describe "with default options" do
    before(:each) do
      @output = Muddle.parse(minimal_email_body)
    end

    it "displays the output" do
      pending
      puts '--------'
      puts @output
      puts '--------'
    end

    it "retains the document structure" do
      @output.should have_xpath('/html')
      @output.should have_xpath('/html/head')
      @output.should have_xpath('/html/head/title')
      #@output.should have_xpath('/html/head/style') # premailer removes the style tag when using hpricot...
      @output.should have_xpath('/html/body')
      @output.should have_xpath('/html/body/table')
      @output.should have_xpath('/html/body/table/tr')
      @output.should have_xpath('/html/body/table/tr/td')
    end
  end
end
