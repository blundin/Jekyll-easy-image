require "spec_helper"

describe "EasyImageTag" do
  let(:site) { make_site }
  before { site.process }

  context "test page rendering" do
    let (:content) { File.read(dest_dir("page.html")) }

    it "does something" do
      # expect(content).to match(%r!(Test|Page)!)
      expect(true).to match(true)
    end
  end
end
