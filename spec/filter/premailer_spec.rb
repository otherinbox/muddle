require 'spec_helper'

describe Muddle::Filter::Premailer do
  let(:f) { Muddle::Filter::Premailer }

  it "can parse full documents" do
    output = f.filter(minimal_email_body)

    output.should have_xpath('//a[@class="inlineme"]')
  end

  it "doesn't add a DTD" do
    output = f.filter(minimal_email_body)

    Nokogiri::XML(output).internal_subset.should be_false
  end

  it "preserves custom DTD's" do
    output = f.filter(email_body_with_custom_dtd)
    puts output

    Nokogiri::XML(output).internal_subset.to_s.should == "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">"
  end

  it "uses config" do
    Muddle.configure do |config|
      config.premailer_options[:line_length] = 50
    end

    premailer = Premailer.new("A string",
                              :remove_comments => true,
                              :with_html_string => true,
                              :adapter => :hpricot,
                              :line_length => 50
                             )

    Premailer.should_receive(:new).with("A string", {
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :hpricot,
      :line_length => 50
    }).and_return premailer

    f.filter("A string")
  end

  it "filters a string" do
    f.filter("A string").should be_true
    f.filter("A string").should be_a(String)
  end

  it "removes comments"
  it "inlines CSS"
  it "converts CSS to attributes"
end
