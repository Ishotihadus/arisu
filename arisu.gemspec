# frozen_string_literal: true

require_relative 'lib/arisu/version'

Gem::Specification.new do |spec|
  spec.name = 'arisu'
  spec.version = Arisu::VERSION
  spec.authors = ['Ishotihadus']
  spec.email = ['hanachan.pao@gmail.com']

  spec.summary = 'Dotenv with google-cloud-secret_manager'
  spec.description = 'Dotenv with google-cloud-secret_manager'
  spec.homepage = 'https://github.com/Ishotihadus/arisu'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) {|f| File.basename(f)}
  spec.require_paths = ['lib']

  spec.add_dependency 'dotenv'
  spec.add_dependency 'google-cloud-secret_manager'
  spec.add_development_dependency 'rake'
end
