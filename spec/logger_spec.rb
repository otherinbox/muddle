require 'spec_helper'

describe Muddle::Logger do
  context "when no logger is configured" do
    subject { described_class.log(:error, 'some logging line') }

    it { should be_false }
  end

  context "when a logger is configured" do
    let(:logger) { double('logger', :error => true) }
    let(:config) { double('config', :logger => logger) }

    before(:each) do
      Muddle.stub!(:config) { config }
    end

    after(:each) do
      described_class.log(:error, 'logging yeah')
    end

    it "uses the configured logger" do
      logger.should_receive(:error).with('logging yeah')
    end
  end
end
