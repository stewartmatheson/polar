$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rspec/core/rake_task'
require 'polar'

GEM_NAME = "polar-renren"
GEM_VERSION = Polar.version

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

desc "Build the Gem"
task :build do
  system "gem build #{GEM_NAME}.gemspec"
end
 
desc "Release to ruby gems"
task :release => :build do
  system "git tag -a #{GEM_VERSION} -m \"Release tag\""
  system "git push origin --tags"
  system "gem push #{GEM_NAME}-#{GEM_VERSION}.gem"
  system "rm #{GEM_NAME}-#{GEM_VERSION}.gem"
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r #{GEM_NAME}.rb"
end
