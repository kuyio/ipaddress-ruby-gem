require "rake"
require "rake/clean"
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |test|
  test.libs << "lib" << "test"
  test.pattern = "test/**/*_test.rb"
  test.verbose = true
  test.warning = true
end

task default: :test

require "rdoc/task"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "ipaddress #{Ipaddress::VERSION}" rescue "ipaddress"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r ipaddress.rb"
end
