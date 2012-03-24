require 'spec_helper'

describe Muddle::EmailBoilerplateFilter do
  let(:ebf) { Muddle::EmailBoilerplateFilter }

  describe "body attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<body></body>").should have_css("body[style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:0; padding:0;']")
    end

    it "doesn't change existing width" do
      ebf.filter("<body style=\"width:50%;\"></body>").should have_css("body[style='width:50% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:0; padding:0;']")
    end
    
    it "doesn't change existing -webkit-text-size-adjustment" do
      ebf.filter("<body style=\"-webkit-text-size-adjustment:50%;\"></body>").should have_css("body[style='width:100% !important; -webkit-text-size-adjustment:50%; -ms-text-size-adjustment:100%; margin:0; padding:0;']")
    end
    
    it "doesn't change existing -ms-text-size-adjustment" do
      ebf.filter("<body style=\"-ms-text-size-adjustment:50%;\"></body>").should have_css("body[style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:50%; margin:0; padding:0;']")
    end
    
    it "doesn't change existing margin" do
      ebf.filter("<body style=\"margin:10px;\"></body>").should have_css("body[style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:10px; padding:0;']")
    end
    
    it "doesn't change existing padding" do
      ebf.filter("<body style=\"padding:10px;\"></body>").should have_css("body[style='width:100% !important; -webkit-text-size-adjustment:100%; -ms-text-size-adjustment:100%; margin:0; padding:10px;']")
    end
  end
    
  # NOTE - note sure what to do with
  # #outlook a {padding:0;}
  # .ExternalClass {width:100%;} 
  # .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;}
  # #backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}
  
  describe "img attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<img src=\"foo\"/>").should have_css("img[style='outline:none; text-decoration:none; -ms-interpolation-mode:bicubic;']")
    end

    it "doesn't change if existing outline" do
      pending "strange Nokogiri parsing issue"
      ebf.filter("<img src=\"foo\" style=\"outline:1px;\"/>").should have_css("img[style='outline:1px; text-decoration:none; -ms-interpolation-mode:bicubic;']")
    end

    it "doesn't change if existing text-decoration" do
      ebf.filter("<img src=\"foo\" style=\"text-decoration:underline;\"/>").should have_css("img[style='outline:none; text-decoration:underline; -ms-interpolation-mode:bicubic;']")
    end

    it "doesn't change if existing ms-interpolation-mode" do
      ebf.filter("<img src=\"foo\" style=\"-ms-interpolation-mode:cubic;\"/>").should have_css("img[style='outline:none; text-decoration:none; -ms-interpolation-mode:cubic;']")
    end
  end

  describe "a img attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<a><img src=\"foo\"/></a>").should have_css("img[style='border:none;']")
    end

    it "doesn't change if existing" do
      ebf.filter("<a><img src=\"foo\" style=\"border:1px solid black;\"/></a>").should have_css("img[style='border:1px solid black;']")
    end
  end

  # NOTE not sure what to do with
  # .image_fix {display:block;}

  describe "p attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<p></p>").should have_css("p[style='margin:1em 0;']")
    end

    it "doesn't change if existing" do
      ebf.filter("<p style=\"margin:1em;\"></p>").should have_css("p[style='margin:2em;']")
    end
  end

  describe "h attributes" do
    it "sets the attribute if missing" do
      ['h1','h2','h3','h4','h5'].each do |tag|
        ebf.filter("<#{tag}></#{tag}>").should have_css("#{tag}[style='color:black !important;']")
      end
    end

    it "doesn't change if existing" do
      ['h1','h2','h3','h4','h5'].each do |tag|
        ebf.filter("<#{tag} style=\"color:blue;\"></#{tag}>").should have_css("#{tag}[style='color:blue;']")
      end
    end
  end

  describe "h a attributes" do
    it "sets the attribute if missing" do
      ['h1','h2','h3','h4','h5','h6'].each do |tag|
        ebf.filter("<#{tag}><a></a></#{tag}>").should have_css("a[style='color:blue !important;']")
      end
    end
    
    it "doesn't change if existing" do
      ['h1','h2','h3','h4','h5','h6'].each do |tag|
        ebf.filter("<#{tag}><a style=\"color:red;\"></a></#{tag}>").should have_css("a[style='color:e']")
      end
    end
  end

  describe "a attributes" do
    it "sets the attribute if missing" do
      ebf.filter("<a></a>").should have_css("a[style='color:blue']")
    end

    it "doesn't change if existing" do
      ebf.filter("<a style=\"color:red;\"></a>").should have_css("a[style='color:blue']")
    end
  end

  # NOTE - html boilerplate also suggests inlining a:active and a:visited 
  # I have no idea how to inline that...
  # Applies to a and h a
  # for now just including it in the style decl below

  it "inserts a style declaration for non-inlined styles if <head> found" do
    ebf.filter('<html><head></head></html>').should have_css('style')
  end
end
