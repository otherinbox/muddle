require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Configuration do
  context "with default options" do
    its(:parse_with_premailer) { should be_true }
    its(:insert_boilerplate_styles) { should be_true }
    its(:insert_boilerplate_css) { should be_true }
    its(:insert_boilerplate_attributes) { should be_true }
    its(:validate_html) { should be_true }
    its(:generate_plain_text) { should be_false }
    its(:logger) { should be_nil }

    describe "premailer_options" do
      subject { Muddle::Configuration.new.premailer_options }

      its([:remove_comments]) { should be_true }
      its([:with_html_string]) { should be_true }
      its([:adapter]) { should == :hpricot }
    end
  end

  context "with some custom options" do
    let(:logger) { double('logger') }

    subject do
      Muddle::Configuration.new.configure do |config|
        config.parse_with_premailer = false
        config.insert_boilerplate_styles = false
        config.insert_boilerplate_css = false
        config.insert_boilerplate_attributes = false
        config.validate_html = false
        config.generate_plain_text = true
        config.logger = logger
      end
    end

    its(:parse_with_premailer) { should be_false }
    its(:insert_boilerplate_styles) { should be_false }
    its(:insert_boilerplate_css) { should be_false }
    its(:insert_boilerplate_attributes) { should be_false }
    its(:validate_html) { should be_false }
    its(:generate_plain_text) { should be_true }
    its(:logger) { should == logger }

    describe "premailer_options" do
      subject do
        Muddle::Configuration.new.configure { |config|
          config.premailer_options[:line_length] = 50
        }.premailer_options
      end

      its([:remove_comments]) { should be_true }
      its([:with_html_string]) { should be_true }
      its([:adapter]) { should == :hpricot }
      its([:line_length]) { should == 50 }
    end
  end
end
