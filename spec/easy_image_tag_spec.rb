require "spec_helper"

describe (Jekyll::EasyImages) do
  let(:config_options) do
    {
      "source": source_dir,
      "destination": dest_dir,
      "url": "http://example.org",
      "easy_images": {
        "srcset": {
          "resized_images": "2"
        }
      }
    }
  end

  let(:config) do
    Jekyll.configuration(config_options)
  end

  let(:site)     { Jekyll::Site.new(config) }

  before(:each) do
    site.process
  end

  context "Bootstrap test page" do
    let(:content) { File.read(dest_dir("bootstrap_test_page.html")) }
    let(:overrides) do
      {
        "easy_images": {
          "responsive_image_class": "img-fluid"
        }
      }
    end
    let (:config) do
      Jekyll.configuration(Jekyll::Utils.deep_merge_hashes(config_options, overrides))
    end

    it "renders" do
      expect(content).to match("Jekyll Easy Image Plugin: Bootstrap Test Page")
    end

    it "has added the responsive image class to an img with no existing class" do
      expect(content).to have_tag('img#3', with: { class: ['img-fluid'] })
      expect(content).to have_tag('img#3', without: { class: ['image', 'image2'] })
    end

    it "has an img tag with multiple classes passed through" do
      expect(content).to have_tag('img#2', with: { class: ['img-fluid', 'image', 'image2'] })
    end

    it "has an img tag with the Bootstrap responsive image class" do
      expect(content).to have_tag('img#1', with: { class: ['image', 'img-fluid'] })
      expect(content).to have_tag('img#1', without: { class: ['image2'] })
    end
  end
end
