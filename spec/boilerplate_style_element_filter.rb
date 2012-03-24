require 'spec_helper'

describe Muddle::BoilerplateStyleElementFilter do
  let(:ebf) { Muddle::BoilerplateStyleElementFilter }

  it "can parse full documents" do
    email = <<-EMAIL
      !DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"&gt;
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head></head>
        <body>
          <h1>hey</h1>
        </body>
      </html>'
      EMAIL
    
    ebf.filter(email).should have_xpath('//head/style')
  end

  it "inserts a style declaration for non-inlined styles if <head> found" do
    ebf.filter('<html><head></head></html>').should have_xpath('//head/style')
  end
end
