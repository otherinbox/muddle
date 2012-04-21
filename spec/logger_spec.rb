require 'spec_helper'

describe Muddle::Logger do
  context "when no logger is configured" do
    subject { described_class.log(:error, 'some logging line') }

    it { should be_false }
  end

  context "when a logger is configured" do
    logger { double('logger', :error => true) }
    config { double('config', :logger => logger) }

    before(:each) do
      Muddle.
    end

    after(:each) do
      logger.should_receive(:error).with('logging yeah')
    end
  end
end
