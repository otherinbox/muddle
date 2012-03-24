require 'spec_helper'

describe Muddle::PremailerFilter do
  let(:pmf) { Muddle::PremailerFilter }

  it "uses config" do
    Muddle.configure do |config|
      config.premailer[:line_length] = 50
    end

    premailer = Premailer.new("A string", :with_html_string => true)

    Premailer.should_receive(:new).with("A string", {
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :nokogiri,
      :line_length => 50
    }).and_return premailer

    pmf.filter("A string")
  end

  it "filters a string" do
    pmf.filter("A string").should be_true
    pmf.filter("A string").should be_a(String)
  end

  it "removes comments"
  it "inlines CSS"
  it "converts CSS to attributes"
end
