Gem::Specification.new do |spec|
  spec.name = "Polar"
  spec.version = "0.0.1"
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
end
