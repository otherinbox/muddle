require 'spec_helper'

describe Muddle::BoilerplateStyleElementFilter do
  let(:f) { Muddle::BoilerplateStyleElementFilter }

  it "can parse full documents" do
    output = f.filter(minimal_email_body)

    xpath(output, '//style').count.should eql(2)
  end

  it "inserts a style declaration for non-inlined styles if <head> found" do
    f.filter('<html><head></head></html>').should have_xpath('//head/style')
  end
end
