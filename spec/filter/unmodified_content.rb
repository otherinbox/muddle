# encoding: utf-8
require 'spec_helper'

shared_examples_for "unmodified content in minimal email" do |described_class|
  describe "with content that shouldn't be modified" do
    subject { described_class.filter(minimal_email_body) }

    it "doesn't modify UTF8 special characters" do
      subject.should include "©"
      subject.should include "™"
      subject.should include "¶"
    end

    it "doesn't modify named HTML special characters" do
      subject.should include "&copy;"
    end

    it "doesn't modify numbered HTML special characters" do
      subject.should include "&#8482;"
    end
  end
end
