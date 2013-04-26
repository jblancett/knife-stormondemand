require "knife-stormondemand/version"

Gem::Specification.new do |s|
	s.name = "knife-stormondemand"
	s.version = Knife::Linode::VERSION
	s.has_rdoc = false
	s.authors = ["Josh Blancett"]
	s.email = ["JoshBlancet@gmail.com"]
	s.summary = "StormOnDemand support for Chef's Knife Command"
	s.description = s.summary
	s.files = `git ls-files`.split("\n")
	s.add_dependency "fog", "~> 1.0"
	s.require_paths = ["lib"]
end
