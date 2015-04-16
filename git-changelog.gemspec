# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/changelog/version'

Gem::Specification.new do |spec|
  spec.name          = "git-changelog"
  spec.version       = Git::Changelog::VERSION
  spec.authors       = ["Franz Kißig"]
  spec.email         = ["h@entire.network"]
  spec.summary       = %q{Creates a Markdown formatted changelog file out of git log.}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/velaluqa/git-changelog"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
