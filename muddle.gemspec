# -*- encoding: utf-8 -*-
require File.expand_path('../lib/muddle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Michael", "Ben Hamill"]
  gem.email         = ["git-commits@benhamill.com"]
  gem.description   = %q{Email clients are not web browsers. They render html all funny, to put it politely. In general, the best practices for writing HTML that will look good in an email are the exact inverse from those that you should use for a web page. Remembering all those differences sucks.}
  gem.summary       = %q{Never type all the annoying markup that emails demand again.}
  gem.homepage      = "http://github.com/otherinbox/muddle"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "muddle"
  gem.require_paths = ["lib"]
  gem.version       = Muddle::VERSION

  gem.add_dependency 'premailer', '~>1.7.3'
  gem.add_dependency 'nokogiri', '~>1.5.0'
  gem.add_dependency 'hpricot', '>=0.6'
  # gem.add_dependency 'hpricot', '~>0.8.6'
  gem.add_dependency 'css_parser', '~>1.2.6'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'email_spec'
  gem.add_development_dependency 'mail'
  gem.add_development_dependency 'pry'
end
