require 'spec_helper'

describe Muddle::Filter::BoilerplateAttributes do
  context "with a minimal email" do
    subject { Muddle::Filter::BoilerplateAttributes.filter(minimal_email_body) }

    it "injects cellpadding into tables" do
      subject.should have_xpath('//table[@cellpadding="0"]')
    end

    it "injects cellspacing into tables" do
      subject.should have_xpath('//table[@cellspacing="0"]')
    end

    it "injects border 0 into tables" do
      subject.should have_xpath('//table[@border="0"]')
    end

    it "injects align center into tables" do
      subject.should have_xpath('//table[@align="center"]')
    end

    it "injects valign top into tds" do
      subject.should have_xpath('//td[@valign="top"]')
    end

    it "injects target _blank into anchors" do
      subject.should have_xpath('//a[@target="_blank"]')
    end
  end

  context "with a table" do
    # NOTE: Should these be CSS-aware?

    context "with no attributes" do
      subject { Muddle::Filter::BoilerplateAttributes.filter("<table></table>") }

      it "sets cellpadding to 0" do
        subject.should have_xpath('//table[@cellpadding="0"]')
      end

      it "sets cellspacing to 0" do
        subject.should have_xpath('//table[@cellspacing="0"]')
      end

      it "sets border to 0" do
        subject.should have_xpath('//table[@border="0"]')
      end

      it "sets align to center" do
        subject.should have_xpath('//table[@align="center"]')
      end
    end

    context "with cellpadding" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<table cellpadding="5px"></table>') }

      it "doesn't mess with the cellpadding" do
        subject.should have_xpath('//table[@cellpadding="5px"]')
      end

      it "puts everything else in as the default" do
        subject.should have_xpath('//table[@cellspacing="0"]')
        subject.should have_xpath('//table[@border="0"]')
        subject.should have_xpath('//table[@align="center"]')
      end
    end

    context "with cellspacing" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<table cellspacing="5px"></table>') }

      it "doesn't mess with the cellspacing" do
        subject.should have_xpath('//table[@cellspacing="5px"]')
      end

      it "puts everything else in as the default" do
        subject.should have_xpath('//table[@cellpadding="0"]')
        subject.should have_xpath('//table[@border="0"]')
        subject.should have_xpath('//table[@align="center"]')
      end
    end

    context "with a border" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<table border="5px"></table>') }

      it "doesn't mess with the border" do
        subject.should have_xpath('//table[@border="5px"]')
      end

      it "puts everything else in as the default" do
        subject.should have_xpath('//table[@cellpadding="0"]')
        subject.should have_xpath('//table[@cellspacing="0"]')
        subject.should have_xpath('//table[@align="center"]')
      end
    end

    context "with align" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<table align="right"></table>') }

      it "doesn't mess with the align" do
        subject.should have_xpath('//table[@align="right"]')
      end

      it "puts everything else in as the default" do
        subject.should have_xpath('//table[@cellpadding="0"]')
        subject.should have_xpath('//table[@cellspacing="0"]')
        subject.should have_xpath('//table[@border="0"]')
      end
    end
  end

  context "with a td" do
    context "with no attributes" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<td></td>') }

      it "sets valign to top" do
        subject.should have_xpath('//td[@valign="top"]')
      end
    end

    context "with valign" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<td valign="bottom"></td>') }

      it "doesn't mess with the valign" do
        subject.should have_xpath('//td[@valign="bottom"]')
      end
    end
  end

  context "with an anchor" do
    context "with no attributes" do
      subject { Muddle::Filter::BoilerplateAttributes.filter("<a></a>") }

      it "sets target to _blank" do
        subject.should have_xpath('//a[@target="_blank"]')
      end
    end

    context "with a target" do
      subject { Muddle::Filter::BoilerplateAttributes.filter('<a target="_parent"></a>') }

      it "doesn't mess with the target" do
        subject.should have_xpath('//a[@target="_parent"]')
      end
    end
  end
end
