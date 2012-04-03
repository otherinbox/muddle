require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Configuration do
  context "with default options" do
    its(:parse_with_premailer) { should be_true }
    its(:insert_boilerplate_styles) { should be_true }
    its(:insert_boilerplate_css) { should be_true }
    its(:insert_boilerplate_attributes) { should be_true }
    its(:validate_html) { should be_true }
    its(:generate_plain_text) { should be_false }

    describe "premailer_options" do
      subject { Muddle::Configuration.new.premailer_options }

      its([:remove_comments]) { should be_true }
      its([:with_html_string]) { should be_true }
      its([:adapter]) { should == :hpricot }
    end
  end

  it "accepts a block to configure and sets options" do
    config = Muddle::Configuration.new
    config.configure do |config|
      config.parse_with_premailer = false
      config.insert_boilerplate_styles = false
      config.insert_boilerplate_css = false
      config.insert_boilerplate_attributes = false
      config.validate_html = false
      config.generate_plain_text = true
      config.premailer_options[:line_length] = 50
    end

    config.parse_with_premailer.should be_false
    config.insert_boilerplate_styles.should be_false
    config.insert_boilerplate_css.should be_false
    config.insert_boilerplate_attributes.should be_false
    config.validate_html.should be_false
    config.generate_plain_text.should be_true
    config.premailer_options.should eql({
      :remove_comments => true,
      :with_html_string => true,
      :adapter => :hpricot,
      :line_length => 50
    })
  end

  it "allows direct assignment" do
    config = Muddle::Configuration.new
    config.parse_with_premailer = false
    config.parse_with_premailer.should be_false
  end
end
