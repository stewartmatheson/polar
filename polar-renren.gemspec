Gem::Specification.new do |spec|
  spec.name = "polar-renren"
  spec.version = Polar.vesion
  spec.summary = "Polar is a wrapper around the Renren social network's restful api."
  spec.description = <<-EOF
  Polar is an API wrapper for the Renren social network.
  EOF
  spec.files = Dir["{lib/**/*,spec/*}"] + %w{README.markdown}
  spec.require_path = "lib"
  spec.extra_rdoc_files = %w{README.markdown}
  spec.test_files = Dir["spec/*_spec.rb"]
  spec.author = "Lei, Zhi-Qiang, Stewart Matheson"
  spec.email = "stew@rtmatheson.com"
  spec.homepage = "https://github.com/stewartmatheson/polar"
  spec.platform = Gem::Platform::RUBY
  spec.license = "BSD"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "faraday", "~> 0.7.6"
  spec.add_runtime_dependency "faraday_middleware"
end
