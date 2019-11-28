# Started using this post from the emminently helpful Anatoliy Yastreb: https://ayastreb.me/writing-a-jekyll-plugin/

# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-easy-images/version"
Gem::Specification.new do |spec|
  spec.name          = "jekyll-easy-images"
  spec.summary       = "Easy responsive images in Jekyll blogs"
  spec.description   = "jekyll-easy-images is a Jekyll plugin for easily adding responsive images to Jekyll blog posts"
  spec.version       = Jekyll::Maps::VERSION
  spec.authors       = ["Brian Lundin"]
  spec.email         = ["brian.lundin@gmail.com"]
  spec.homepage      = "https://github.com/blundin/jekyll-easy-images"
  spec.licenses      = ["MIT"]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!) }
  spec.require_paths = ["lib"]
  spec.add_dependency "jekyll", "~> 4.0"
  spec.add_dependency "mini_magick", "~> 4.8"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rspec-html-matchers", "~> 0.9"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-rspec"
end
