require "spec_helper"

describe "EasyImageTag" do
  let(:site) { make_site }
  before { site.process }

  context "test page" do
    let (:content) { File.read(dest_dir("page.html")) }

    it "renders correctly" do
      expect(content).to match(%r!(Test|Page)!)
    end

    it "has an img tag" do
      expect(content).to have_tag('img')
    end
  end
end
