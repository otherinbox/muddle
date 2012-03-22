require 'spec_helper'
require 'mail'

describe Muddle::Interceptor do
  before(:each) do
    Muddle::Parser.stub!(:parse) { 'muddled email body' }
  end

  context "with a multi-part email" do
    let(:email) do
      Mail.new do
        to 'you@you.com'
        from 'me@me.com'
        subject 'Better emails in Rails'

        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<h1>Muddle is awesome!</h1>'
        end

        text_part do
          body 'Muddle is pretty cool.'
        end
      end
    end

    subject { Muddle::Interceptor.new(email) }

    describe "#body_location" do
      it "is the html_part" do
        subject.body_location.should === email.html_part
      end
    end
  end

  context "with a single-part email" do
    let(:email) do
      Mail.new do
        to 'you@you.com'
        from 'me@me.com'
        subject 'Better emails in Rails'
        content_type 'text/html; charset=UTF-8'
        body '<h1>Muddle is awesome!</h1>'
      end
    end

    subject { Muddle::Interceptor.new(email) }

    describe "#body_location" do
      it "is the message's body" do
        subject.body_location.should === email
      end
    end
  end
end
