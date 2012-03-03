# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rake-pipeline-web-filters"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yehuda Katz"]
  s.date = "2011-12-05"
  s.description = "A collection of web filters for rake-pipeline"
  s.email = ["wycats@gmail.com"]
  s.homepage = "http://github.com/wycats/rake-pipeline-web-filters"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Contributed filters for use in rake-pipeline that are useful for web projects, like asset management"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake-pipeline>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<tilt>, [">= 0"])
      s.add_development_dependency(%q<sass>, [">= 0"])
      s.add_development_dependency(%q<compass>, [">= 0"])
    else
      s.add_dependency(%q<rake-pipeline>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<tilt>, [">= 0"])
      s.add_dependency(%q<sass>, [">= 0"])
      s.add_dependency(%q<compass>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-pipeline>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<tilt>, [">= 0"])
    s.add_dependency(%q<sass>, [">= 0"])
    s.add_dependency(%q<compass>, [">= 0"])
  end
end
