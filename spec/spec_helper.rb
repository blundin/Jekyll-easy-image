# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require "rspec-html-matchers"
require "jekyll"
require "jekyll-easy-images"

Jekyll.logger.log_level = :error

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  SOURCE_DIR = File.expand_path("fixtures", __dir__)
  DEST_DIR   = File.expand_path("dest", __dir__)

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end
end
