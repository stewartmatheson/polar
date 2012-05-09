Gem::Specification.new do |spec|
  spec.name = "renren-api"
  spec.version = "0.4"
  spec.summary = "a library to request Renren's API"
  spec.description = <<-EOF
  Polar is an API wrapper for the Renren social network.
  EOF
  spec.files = Dir["{lib/**/*,spec/*}"] + %w{README.markdown}
  spec.require_path = "lib"
  spec.extra_rdoc_files = %w{README.markdown}
  spec.test_files = Dir["spec/*_spec.rb"]
  spec.author = "Lei, Zhi-Qiang, Stewart Matheson"
  spec.email = "zhiqiang.lei@gmail.com"
  spec.homepage = "https://github.com/siegfried/renren-api"
  spec.platform = Gem::Platform::RUBY
  spec.license = "BSD"
end
