require 'spec_helper'

describe Muddle::Filter::PremailerFilter do
  let(:f) { Muddle::Filter::PremailerFilter }

  it "can parse full documents" do
    output = f.filter(minimal_email_body)

    output.should have_xpath('//a[@class="inlineme"]')
  end


  it "uses config" do
    Muddle.configure do |config|
      config.premailer[:line_length] = 50
    end

    premailer = Premailer.new("A string", :with_html_string => true)

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
