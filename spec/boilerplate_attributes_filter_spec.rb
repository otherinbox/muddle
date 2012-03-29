require 'spec_helper'

describe Muddle::Filter::BoilerplateAttributesFilter do
  let(:f) { Muddle::Filter::BoilerplateAttributesFilter }

  it "can parse full documents" do
    output = f.filter(minimal_email_body)

    output.should have_xpath('//table[@cellpadding="0"]')
    output.should have_xpath('//table[@cellspacing="0"]')
    output.should have_xpath('//table[@border="0"]')
    output.should have_xpath('//table[@align="center"]')

    output.should have_xpath('//td[@valign="top"]')
    
    output.should have_xpath('//a[@target="_blank"]')
  end

  describe "table attributes" do
    # NOTE: Should these be CSS-aware?
    
    it "sets the attributes if missing" do
      output = f.filter("<table></table>")
      output.should have_xpath('//table[@cellpadding="0"]')
      output.should have_xpath('//table[@cellspacing="0"]')
      output.should have_xpath('//table[@border="0"]')
      output.should have_xpath('//table[@align="center"]')
    end

    it "doesn't change if existing cellpadding" do
      output = f.filter("<table cellpadding=\"5px\"></table>")
      output.should have_xpath('//table[@cellpadding="5px"]')
      output.should have_xpath('//table[@cellspacing="0"]')
      output.should have_xpath('//table[@border="0"]')
      output.should have_xpath('//table[@align="center"]')
    end

    it "doesn't change if existing cellspacing" do
      output = f.filter("<table cellspacing=\"5px\"></table>")
      output.should have_xpath('//table[@cellpadding="0"]')
      output.should have_xpath('//table[@cellspacing="5px"]')
      output.should have_xpath('//table[@border="0"]')
      output.should have_xpath('//table[@align="center"]')
    end

    it "doesn't change if existing border" do
      output = f.filter("<table border=\"5px\"></table>")
      output.should have_xpath('//table[@cellpadding="0"]')
      output.should have_xpath('//table[@cellspacing="0"]')
      output.should have_xpath('//table[@border="5px"]')
      output.should have_xpath('//table[@align="center"]')
    end

    it "doesn't change if existing align" do
      output = f.filter("<table align=\"right\"></table>")
      output.should have_xpath('//table[@cellpadding="0"]')
      output.should have_xpath('//table[@cellspacing="0"]')
      output.should have_xpath('//table[@border="0"]')
      output.should have_xpath('//table[@align="right"]')
    end
  end

  describe "td attributes" do
    it "sets the attributes if missing" do
      f.filter("<td></td>").should have_xpath('//td[@valign="top"]')
    end

    it "doesn't change if existing valign" do
      f.filter("<td valign=\"bottom\"></td>").should have_xpath('//td[@valign="bottom"]')
    end
  end

  describe "a attributes" do
    it "sets the attributes if missing" do
      f.filter("<a></a>").should have_xpath('//a[@target="_blank"]')
    end

    it "doesn't change if existing _target" do
      f.filter("<a target=\"_parent\"></a>").should have_xpath('//a[@target="_parent"]')
    end
  end
end
