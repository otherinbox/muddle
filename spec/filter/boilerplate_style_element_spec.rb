require 'spec_helper'

describe Muddle::Filter::BoilerplateStyleElement do
  context "with a minimal email" do
    subject { Muddle::Filter::BoilerplateStyleElement.filter(minimal_email_body) }

    it "inserts the boilerplate css that's not meant to be inlined" do
      xpath(subject, 'html/body/style').count.should eql(1)
    end
  end

  context "with a style tag in the body" do
    subject { Muddle::Filter::BoilerplateStyleElement.filter('<html><body><style></style></body></html>') }

    it "adds a second style tag" do
      xpath(subject, 'html/body/style').count.should eql(2)
    end

    it "inserts a style with type text/css" do
      xpath(subject, 'html/body/style').first.attribute('type').value.should == 'text/css'
    end

    it "inserts the boilerplate css into the first style tag" do
      xpath(subject, 'html/body/style').first.content.should include("Boilerplate CSS for HEAD")
    end
  end

  context "with no style tag in the body" do
    subject { Muddle::Filter::BoilerplateStyleElement.filter('<html><body></body></html>') }

    it "adds a second style tag" do
      xpath(subject, 'html/body/style').count.should eql(1)
    end

    it "inserts a style with type text/css" do
      xpath(subject, 'html/body/style').first.attribute('type').value.should == 'text/css'
    end

    it "inserts the boilerplate css into the first style tag" do
      xpath(subject, 'html/body/style').first.content.should include("Boilerplate CSS for HEAD")
    end
  end
end
