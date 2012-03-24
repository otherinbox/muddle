require 'spec_helper'

describe Muddle::EmailBoilerplateFilter do
  let(:ebf) { Muddle::EmailBoilerplateFilter }

  describe "body attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<body></body>").should eql("<body style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:0; padding:0;></body>")
    end

    it "doesn't change existing width" do
      ebf.filter("<body style='width:50%;'></body>").should eql("<body style='width:50% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:0; padding:0;></body>")
    end
    
    it "doesn't change existing -webkit-text-size-adjustment" do
      ebf.filter("<body style='-webkit-text-size-adjustment:50%;'></body>").should eql("<body style='width:100% !important; -webkit-text-size-adjustment:50%; -ms-text-size-adjustment:100%; margin:0; padding:0;></body>")
    end
    
    it "doesn't change existing -ms-text-size-adjustment" do
      ebf.filter("<body style='-ms-text-size-adjustment:50%;'></body>").should eql("<body style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:50%; margin:0; padding:0;></body>")
    end
    
    it "doesn't change existing margin" do
      ebf.filter("<body style='margin:10px;'></body>").should eql("<body style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:10px; padding:0;></body>")
    end
    
    it "doesn't change existing padding" do
      ebf.filter("<body style='padding:10px;'></body>").should eql("<body style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:0; padding:10px;></body>")
    end
  end
    
  # NOTE - note sure what to do with
  # #outlook a {padding:0;}
  # .ExternalClass {width:100%;} 
  # .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}
  # #backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}
  
  describe "img attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<img src='blah'/>").should eql("<img src='blah' style='outline:none; text-decoration:none; -ms-interpolation-mode:bicubic;'/>")
    end

    it "doesn't change if existing outline" do
      ebf.filter("<img src='blah' style='outline:1px solid black;'/>").should eql("<img src='blah' style='outline:1px solid black; text-decoration:none; -ms-interpolation-mode:bicubic;'/>")
    end

    it "doesn't change if existing text-decoration" do
      ebf.filter("<img src='blah' style='text-decoration:underline;'/>").should eql("<img src='blah' style='outline:none; text-decoration:underline; -ms-interpolation-mode:bicubic;'/>")
    end

    it "doesn't change if existing ms-interpolation-mode" do
      ebf.filter("<img src='blah' style='-ms-interpolation-mode:cubic;'/>").should eql("<img src='blah' style='outline:none; text-decoration:none; -ms-interpolation-mode:cubic;'/>")
    end
  end

  describe "a img attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<a><img src='foo'/></a>").should eql("<a><img src='foo' style='border:none'/></a>")
    end

    it "doesn't change if existing" do
      ebf.filter("<a><img src='foo' style='border:1px solid black;'/></a>").should eql("<a><img src='foo' style='border:1px solid black;'/></a>")
    end
  end

  # NOTE not sure what to do with
  # .image_fix {display:block;}

  describe "p attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<p></p>").should eql("<p style='margin:1em 0;'></p>")
    end

    it "doesn't change if existing" do
      ebf.filter("<p style='margin:1em;'></p>").should eql("<p style='margin:2em;'></p>")
    end
  end

  describe "h attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<h1></h1> <h2></h2> <h3></h3> <h4></h4> <h5></h5> <h6></h6>").should eql(
       "<h1 style='color:black !important;'></h1> <h2 style='color:black !important;></h2> <h3 style='color:black !important;></h3> <h4 style='color:black !important;></h4> <h5 style='color:black !important;></h5> <h6 style='color:black !important;></h6>"
      )
    end

    it "doesn't change if existing" do
      ebf.filter("<h1 style='color:blue;'></h1> <h2 style='color:blue;'></h2> <h3 style='color:blue;'></h3> <h4 style='color:blue;'></h4> <h5 style='color:blue;'></h5> <h6 style='color:blue;'></h6>").should eql(
      "<h1 style='color:blue;'></h1> <h2 style='color:blue;'></h2> <h3 style='color:blue;'></h3> <h4 style='color:blue;'></h4> <h5 style='color:blue;'></h5> <h6 style='color:blue;'></h6>"
      )
    end
  end

  describe "h a attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<h1><a></a></h1> <h2><a></a></h2> <h3><a></a></h3> <h4><a></a></h4> <h5><a></a></h5> <h6><a></a></h6>").should eql(
       "<h1 style='color:black !important;'><a style='color:blue !important'></a></h1> <h2 style='color:black !important;><a style='color:blue !important'></a></h2> <h3 style='color:black !important;><a style='color:blue !important'></a></h3> <h4 style='color:black !important;><a style='color:blue !important'></a></h4> <h5 style='color:black !important;><a style='color:blue !important'></a></h5> <h6 style='color:black !important;><a style='color:blue !important'></a></h6>"
      )
    end
    
    it "doesn't change if existing" do
      ebf.filter("<h1><a style='color:red;'></a></h1> <h2><a style='color:red;'></a></h2> <h3><a style='color:red;'></a></h3> <h4><a style='color:red;'></a></h4> <h5><a style='color:red;'></a></h5> <h6><a style='color:red;'></a></h6>").should eql(
       "<h1 style='color:black !important;'><a style='color:red;'></a></h1> <h2 style='color:black !important;><a style='color:red;'></a></h2> <h3 style='color:black !important;><a style='color:red;'></a></h3> <h4 style='color:black !important;><a style='color:red;'></a></h4> <h5 style='color:black !important;><a style='color:red;'></a></h5> <h6 style='color:black !important;><a style='color:red;'></a></h6>"
      )
    end
  end

  describe "a attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<a></a>").should eql("<a style='color:blue;'></a>")
    end

    it "doesn't change if existing" do
      ebf.filter("<a style='color:red;'></a>").should eql("<a style='color:red;'></a>")
    end
  end

  # NOTE - html boilerplate also suggests inlining a:active and a:visited 
  # I have no idea how to inline that...
  # Applies to a and h a
  # for now just including it in the style decl below

  it "inserts a style declaration for non-inlined styles if <head> found" do
    body <<EMAIL
<html>
  <head>
  </head>
</html>
EMAIL

    expected <<EMAIL
<html>
  <head>
    <style type="text/css">
      #outlook a {padding:0;}
      #backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}

      .ExternalClass {width:100%;}
      .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}
      .image_fix {display:block;}

      h1 a:active, h2 a:active,  h3 a:active, h4 a:active, h5 a:active, h6 a:active {color: red !important;}
      h1 a:visited, h2 a:visited,  h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited {color: purple !important;}

      @media only screen and (max-device-width: 480px) {
        a[href^="tel"], a[href^="sms"] {
          text-decoration: none;
          color: blue;
          pointer-events: none;
          cursor: default;
        }
        .mobile_link a[href^="tel"], .mobile_link a[href^="sms"] {
          text-decoration: default;
          color: orange !important;
          pointer-events: auto;
          cursor: default;
        }
      }
      @media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {
        a[href^="tel"], a[href^="sms"] {
          text-decoration: none;
          color: blue;
          pointer-events: none;
          cursor: default;
        }
        .mobile_link a[href^="tel"], .mobile_link a[href^="sms"] {
          text-decoration: default;
          color: orange !important;
          pointer-events: auto;
          cursor: default;
        }
      }
    </style>
  </head>
</html>
EMAIL

    ebf.filter(body).should eql(expected)
  end
end
