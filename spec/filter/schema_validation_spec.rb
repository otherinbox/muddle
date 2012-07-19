# encoding: utf-8
require 'spec_helper'
require 'filter/unmodified_content'

describe Muddle::Filter::SchemaValidation do
  context "with a minimal email" do
    subject { Muddle::Filter::SchemaValidation.filter(minimal_email_body) }

    it "converts HTML special characters to US-ASCII" do
      subject.should include("&#169;")
      subject.should include("&#8482;")
      subject.should include("&#182;")
    end

    it "doesn't leave any special characters" do
      subject.should_not include "©"
      subject.should_not include "™"
      subject.should_not include "¶"
    end
  end
end
