require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Muddle do
  before(:each) do
    reset_muddle_module
  end

  describe ".parser" do
    it "returns a Muddle::Parser object" do
      Muddle.parser.should be_a(Muddle::Parser)
    end
  end

  describe ".parse" do
    let(:parser) { double(Muddle::Parser) }

    before(:each) { Muddle::Parser.stub!(:new) { parser } }

    it "passes stuff to the parser" do
      parser.should_receive(:parse).with('email')

      Muddle.parse('email')
    end
  end

  describe ".config" do
    it "returns a Muddle::Configuration object" do
      Muddle.config.should be_a(Muddle::Configuration)
    end
  end

  describe ".configure" do
    it "yields a Muddle::Configureation object" do
      Muddle.configure do |config|
        config.should be_a(Muddle::Configuration)
      end
    end
  end
end
