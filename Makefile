GEM_NAME = ipaddress
GEM_VERSION = $(shell cat VERSION)
GEM_FILE = $(GEM_NAME)-$(GEM_VERSION).gem

.DEFAULT: test

.PHONY: test spec build clean

test: spec

spec:
	$(info Running tests with minitest ...)
	@bundle exec ruby -Ilib -Itest -e "Dir.glob('test/**/*_test.rb').each { |f| require File.expand_path(f) }"

build: clean
	$(info Building $(GEM_FILE) ...)
	@gem build $(GEM_NAME).gemspec

clean:
	$(info Cleaning ...)
	@rm -f $(GEM_NAME)-*.gem
