require 'spec_helper'

describe Muddle::Interceptor do
  before(:each) do
    Muddle::Parser.stub!(:parse) { 'muddled email body' }
  end

  subject { Muddle::Interceptor }

  context "with a multi-part email" do
    let(:email) { multi_part_email }

    it "muddles the html part" do
      output = subject.delivering_email(email).html_part.body.to_s
      output.should have_xpath('//body[@style="width: 100% !important; margin: 0; padding: 0; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%;"]')
    end

    it "doesn't muddle the plaintext part" do
      subject.delivering_email(email).text_part.body.to_s.should == 'Muddle is pretty cool.'
    end
  end

  context "with a single-part email" do
    let(:email) { html_email }

    it "muddles the email body" do
      output = subject.delivering_email(email).body.to_s
      output.should have_xpath('//body[@style="width: 100% !important; margin: 0; padding: 0; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%;"]')
    end
  end

  context "with a single-part plaintext email" do
    let(:email) { plaintext_email }

    it "doesn't muddle the email body" do
      subject.delivering_email(email).body.to_s.should == 'Muddle is pretty cool.'
    end
  end
end
