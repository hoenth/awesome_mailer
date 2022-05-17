# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "awesomemailer"
  s.version = "0.3.1"

  s.license = "MIT"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Flip Sasser"]
  s.date = "2013-06-13"
  s.description = "\n      AwesomeMailer embeds your e-mail CSS inline, allowing you to write e-mail templates without worrying too much about stylesheets\n    "
  s.email = "flip@x451.com"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "CHANGELOG",
    "README.md",
    "VERSION",
    "awesomemailer.gemspec",
    "lib/awesome_mailer.rb",
    "lib/awesome_mailer/base.rb",
    "lib/awesome_mailer/renderer.rb",
    "lib/awesomemailer.rb"
  ]
  s.homepage = "http://github.com/Plinq/awesome_mailer"
  s.require_paths = ["lib"]
  s.summary = "An ActionMailer extension that embeds CSS inline in e-mails"

  s.add_runtime_dependency 'rails', '~> 5.2', '>= 5.2.0'
  s.add_runtime_dependency 'addressable', '>= 2.0'
  s.add_runtime_dependency 'css_parser', '>= 1.11.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.13.3'

  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'jeweler'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'simplecov'
end

