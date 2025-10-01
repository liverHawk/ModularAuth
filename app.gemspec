# frozen_string_literal: true

require_relative "lib/modular_auth/version"

Gem::Specification.new do |spec|
  spec.name = "ModularAuth"
  spec.version = ModularAuth::VERSION
  spec.authors = ["liverHawk"]
  spec.email = ["liverhawk@protonmail.com"]

  spec.summary = "A modular, dependency-free authentication gem for Rack applications"
  spec.description = <<~DESC
    ModularAuth is a lightweight, modular authentication framework for Rack applications.
    It provides multiple authentication methods (password, JWT, OAuth, TOTP) that can be
    flexibly combined without external dependencies. Built with security and performance
    in mind, it supports Rails, Sinatra, Hanami, and any Rack-compatible framework.
    
    Key features:
    - Zero external dependencies
    - Modular authentication system
    - High performance (50ms response time)
    - Multiple authentication methods
    - Rack middleware integration
    - Comprehensive security features
  DESC
  spec.homepage = "https://github.com/liverHawk/ModularAuth"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/liverHawk/ModularAuth"
  spec.metadata["changelog_uri"] = "https://github.com/liverHawk/ModularAuth/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
