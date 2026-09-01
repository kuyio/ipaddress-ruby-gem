require_relative "lib/ipaddress/version"

Gem::Specification.new do |s|
  s.name = "ipaddress"
  s.version = Ipaddress::VERSION

  s.required_ruby_version = ">= 3.3"
  s.require_paths = ["lib"]
  s.authors = ["Nicolas Bettenburg", "Marco Ceresa", "Mike Mackintosh"]
  s.email = ["nicbet@kuy.io"]
  s.description = "IPAddress is a Ruby library designed to make manipulation " \
    "of IPv4 and IPv6 addresses both powerful and simple. It maintains " \
    "a layer of compatibility with Ruby's own IPAddr, while " \
    "addressing many of its issues. This fork adds overlaps?, subnet_of? " \
    "and address_exclude methods."
  s.summary = "IPv4/IPv6 address manipulation library"
  s.homepage = "https://github.com/kuyio/ipaddress-ruby-gem"
  s.license = "MIT"

  s.metadata = {
    "source_code_uri" => s.homepage,
    "changelog_uri" => "#{s.homepage}/blob/main/CHANGELOG.md",
    "bug_tracker_uri" => "#{s.homepage}/issues"
  }

  s.files = Dir["lib/**/*.rb", "LICENSE.txt", "README.md"]

  s.add_development_dependency "bundler", ">= 2.0"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "minitest", "~> 5.8", ">= 5.8.4"
end
