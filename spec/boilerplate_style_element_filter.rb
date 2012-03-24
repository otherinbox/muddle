require 'spec_helper'

describe Muddle::BoilerplateStyleElementFilter do
  let(:ebf) { Muddle::BoilerplateStyleElementFilter }

  it "inserts a style declaration for non-inlined styles if <head> found" do
    ebf.filter('<html><head></head></html>').should have_css('style')
  end
end
