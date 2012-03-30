require 'spec_helper'

describe Muddle::Filter::BoilerplateStyleElement do
  let(:f) { Muddle::Filter::BoilerplateStyleElement }

  it "can parse full documents" do
    output = f.filter(minimal_email_body)

    xpath(output, 'html/body/style').count.should eql(1)
  end

  it "inserts a <body> element if missing" do
    output = f.filter('<html><body>woot</body></html>')
    output.should have_xpath('html/body')
  end

  it "inserts a style declaration for non-inlined styles if <body> found" do
    f.filter('<html><body></body></html>').should have_xpath('html/body/style')
  end
end
