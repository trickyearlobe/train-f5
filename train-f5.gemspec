# frozen_string_literal: true

require_relative "lib/train-f5/version"

Gem::Specification.new do |spec|
  spec.name = "train-f5"
  spec.version = TrainPlugins::F5::VERSION
  spec.authors = ["Richard Nixon"]
  spec.email = ["richard.nixon@btinternet"]

  spec.summary = "A Train plugin for F5 BigIP"
  spec.description = "A Train plugin that allows Inspec to call the F5 REST API"
  spec.homepage = "https://github.com/trickyearlobe/train-f5"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "train"
end
