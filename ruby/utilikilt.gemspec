# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "utilikilt/version"

Gem::Specification.new do |s|
  s.name        = "utilikilt"
  s.version     = Utilikilt::VERSION
  s.authors     = ["Pete Hodgson"]
  s.email       = ["github@thepete.net"]
  s.homepage    = "http://github.com/moredip/utilikilt"
  s.summary     = %q{Seriously simple prototyping}
  s.description = %q{Prototype your UI development using tools like HAML and SASS with your changes showing up in the browser every time you save.}

  s.rubyforge_project = "utilikilt"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "rb-fsevent"
  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "sass"
  s.add_runtime_dependency "redcarpet"
  s.add_runtime_dependency "tilt"
  s.add_runtime_dependency "powder"
  s.add_runtime_dependency "showoff-io"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
