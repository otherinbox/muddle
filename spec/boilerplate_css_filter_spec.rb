require 'spec_helper'

describe Muddle::BoilerplateCSSFilter do
  let(:f) { Muddle::BoilerplateCSSFilter }

  it "can parse full documents" do
    output = f.filter(minimal_email_body)

    xpath(output, '//head').count.should eql(1)
    xpath(output, '//style').count.should eql(2)
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
