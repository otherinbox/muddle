require 'spec_helper'
require 'filter/unmodified_content'

describe Muddle::Filter::Premailer do
  include_examples "unmodified content in minimal email", described_class
  
  context "with a minimal email" do
    subject { Muddle::Filter::Premailer.filter(minimal_email_body) }

    it "can parse full documents" do
      subject.should have_xpath('//a[@class="inlineme"]')
    end

    it "doesn't add a DTD" do
      Nokogiri::XML(subject).internal_subset.should be_false
    end
  end

  context "with a custom DTD" do
    subject { Muddle::Filter::Premailer.filter(email_body_with_custom_dtd) }

    it "preserves custom DTD's" do
      Nokogiri::XML(subject).internal_subset.to_s.should == "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">"
    end
  end

  context "with configured options" do
    let(:premailer_options) do
      {
        :remove_comments  => true,
        :with_html_string => true,
        :adapter          => :hpricot,
        :line_length      => 50
      }
    end

    let!(:new_premailer) { Premailer.new('A string', premailer_options) }

    before(:each) do
      Muddle.configure do |config|
        config.premailer_options[:line_length] = 50
      end
    end

    after(:each) do
      Muddle::Filter::Premailer.filter('A string')
    end

    it "uses the options" do
      Premailer.should_receive(:new).with("A string", premailer_options).and_return(new_premailer)
    end
  end

  context "with comments" do
    it "removes comments"
  end

  context "with styles in the HTML" do
    it "inlines CSS"
    it "converts CSS to attributes"
  end

  context "with an external style sheet" do
    it "inlines CSS"
    it "converts CSS to attributes"
  end
end
