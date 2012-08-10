require 'spec_helper'
require 'filter/unmodified_content'

describe Muddle::Filter::BoilerplateCSS do
  include_examples "unmodified content in minimal email", described_class

  context "with a minimal email" do
    subject { Muddle::Filter::BoilerplateCSS.filter(minimal_email_body) }

    it "has only one head" do
      xpath(subject, '//head').count.should eql(1)
    end

    it "inserts an extra style tag" do
      xpath(subject, '//style').count.should eql(2)
    end

    it "inserts the boilerplate css into the head" do
      xpath(subject, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
    end

    it "keeps the head before the body" do
      subject.should have_xpath('/html/body/preceding-sibling::head')
    end
  end

  context "with no head tag" do
    let(:email) { "<html><body><h1>foo</h1><body></html>" }

    subject { Muddle::Filter::BoilerplateCSS.filter(email) }

    it "retains the html tag" do
      subject.should have_xpath('html')
    end

    it "adds a head tag inside the html tag" do
      subject.should have_xpath('html/head')
    end

    it "adds a style tag into the head tag" do
      subject.should have_xpath('html/head/style[@type="text/css"]')
    end

    it "puts the boilerplate css into the style tag" do
      xpath(subject, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
    end

    it "puts the head tag before the body" do
      subject.should have_xpath('/html/body/preceding-sibling::head')
    end
  end

  context "with an existing style in a head tag" do
    let(:email) { "<html><head><style></style></head> <h1>foo</h1></html>" }

    subject { Muddle::Filter::BoilerplateCSS.filter(email) }

    it "adds a second style tag" do
      xpath(subject, 'html/head/style').count.should eql(2)
    end

    it "inserts a style with type text/css" do
      xpath(subject, 'html/head/style').first.attribute('type').value.should == 'text/css'
    end

    it "inserts the boilerplate css into the first style tag" do
      xpath(subject, 'html/head/style').first.content.should include("Boilerplate CSS for Inlining")
    end
  end

  context "with a head and no style tag" do
    let(:email) { "<html><head></head> <h1>foo</h1></html>" }

    subject { Muddle::Filter::BoilerplateCSS.filter(email) }

    it "inserts a style tag" do
      xpath(subject, 'html/head/style[@type="text/css"]').should be_true
    end

    it "inserts the boilerplate css into the style tag" do
      xpath(subject, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
    end
  end
end
