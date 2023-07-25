require_relative "lib/guidance/version"

Gem::Specification.new do |spec|
  spec.name = "guidance"
  spec.version = Guidance::VERSION
  spec.authors = ["Noah Horton"]
  spec.email = ["noah@unsupervised.com"]

  spec.summary = "Microsoft Guidance for Ruby"
  spec.homepage = "https://github.com/Unsupervisedcom/guideance-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/Unsupervisedcom/guideance-rails/issues",
    "changelog_uri" => "https://github.com/Unsupervisedcom/guideance-rails/releases",
    "source_code_uri" => "https://github.com/Unsupervisedcom/guideance-rails",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end