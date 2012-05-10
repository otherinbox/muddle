require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle::Parser do
  let(:config) { double(Muddle::Configuration).as_null_object }

  before(:each) do
    filters = [
      Muddle::Filter::BoilerplateCSS,
      Muddle::Filter::Premailer,
      Muddle::Filter::BoilerplateStyleElement,
      Muddle::Filter::BoilerplateAttributes,
      Muddle::Filter::SchemaValidation,
    ]

    filters.each do |filter|
      filter.stub!(:filter) { |arg| arg }
    end

    Muddle.stub!(:config) { config }
  end

  after(:each) { subject.parse('email') }

  context "with BoilerplateCSS on" do
    before(:each) do
      config.stub!(:insert_boilerplate_css) { true }
    end

    it "calls the css filter" do
      Muddle::Filter::BoilerplateCSS.should_receive(:filter).with('email')
    end
  end

  context "with BoilerplateCSS off" do
    before(:each) do
      config.stub!(:insert_boilerplate_css) { false }
    end

    it "doesn't call the css filter" do
      Muddle::Filter::BoilerplateCSS.should_not_receive(:filter).with('email')
    end
  end

  context "with Premailer on" do
    before(:each) do
      config.stub!(:parse_with_premailer) { true }
    end

    it "calls the premailer filter" do
      Muddle::Filter::Premailer.should_receive(:filter).with('email')
    end
  end

  context "with Premailer off" do
    before(:each) do
      config.stub!(:parse_with_premailer) { false }
    end

    it "doesn't call the premailer filter" do
      Muddle::Filter::Premailer.should_not_receive(:filter).with('email')
    end
  end

  context "with BoilerplateStyleElement on" do
    before(:each) do
      config.stub!(:insert_boilerplate_styles) { true }
    end

    it "calls the style filter" do
      Muddle::Filter::BoilerplateStyleElement.should_receive(:filter).with('email')
    end
  end

  context "with BoilerplateStyleElement off" do
    before(:each) do
      config.stub!(:insert_boilerplate_styles) { false }
    end

    it "doesn't call the style filter" do
      Muddle::Filter::BoilerplateStyleElement.should_not_receive(:filter).with('email')
    end
  end

  context "with BoilerplateAttributes on" do
    before(:each) do
      config.stub!(:insert_boilerplate_attributes) { true }
    end

    it "calls the attribute filter" do
      Muddle::Filter::BoilerplateAttributes.should_receive(:filter).with('email')
    end
  end

  context "with BoilerplateAttributes off" do
    before(:each) do
      config.stub!(:insert_boilerplate_attributes) { false }
    end

    it "doesn't call the attribute filter" do
      Muddle::Filter::BoilerplateAttributes.should_not_receive(:filter).with('email')
    end
  end

  context "with SchemaValidation on" do
    before(:each) do
      config.stub!(:validate_html) { true }
    end

    it "calls the validation filter" do
      Muddle::Filter::SchemaValidation.should_receive(:filter).with('email')
    end
  end

  context "with SchemaValidation off" do
    before(:each) do
      config.stub!(:validate_html) { false }
    end

    it "doesn't call the validation filter" do
      Muddle::Filter::SchemaValidation.should_not_receive(:filter).with('email')
    end
  end
end
