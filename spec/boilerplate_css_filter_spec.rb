require 'spec_helper'

describe Muddle::BoilerplateCSSFilter do
  let(:f) { Muddle::BoilerplateCSSFilter }

  it "can parse full documents" do
    email = <<-EMAIL
    !DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd"
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <style></style>
      </head>
      <body>
        <h1>hey</h1>
      </body>
    </html>'
    EMAIL

    output = f.filter(email)

    xpath(output, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
  end

  it "adds <html>, <head> and a <style> tag if needed" do
    email = "<h1>foo</h1>"
 
    output = f.filter(email)

    xpath(output, 'html').should be_true
    xpath(output, 'html/head').should be_true
    xpath(output, 'html/head/style[@type="text/css"]').should be_true
    xpath(output, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
  end

  it "adds <head> and <style> tags if needed" do
    email = "<html><h1>foo</h1></html>"

    output = f.filter(email)

    xpath(output, 'html/head').should be_true
    xpath(output, 'html/head/style[@type="text/css"]').should be_true
    xpath(output, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
  end

  it "adds the <style> tag before existing one" do
    email = "<html><head><style></style></head> <h1>foo</h1></html>"

    output = f.filter(email)

    xpath(output, 'html/head/style').count.should eql(2)
    xpath(output, 'html/head/style[@type="text/css"]').should be_true
    xpath(output, 'html/head/style[@type="text/css"]').first.content.should include("Boilerplate CSS for Inlining")
  end

  it "adds the <style> tag if none are defined" do
    email = "<html><head></head> <h1>foo</h1></html>"

    output = f.filter(email)

    xpath(output, 'html/head/style[@type="text/css"]').should be_true
    xpath(output, 'html/head/style[@type="text/css"]').first.content.should include('Boilerplate CSS for Inlining')
  end
end
