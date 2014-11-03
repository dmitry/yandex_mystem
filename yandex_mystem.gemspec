# -*- encoding: utf-8 -*-
require File.expand_path('../lib/yandex_mystem/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Dmitry Polushkin']
  gem.email         = %w(dmitry.polushkin@gmail.com)
  gem.homepage      = 'http://github.com/dmitry/yandex_mystem'
  gem.description   = %q{Mystem is a software that provided by the Yandex only for non-commercial project. With use of it you can detect base forms of the words in a text, make a simple morphological analysis of russian words.}
  gem.summary       = %q{Yandex Mystem makes morphological analysis of a russian text}
  gem.homepage      = ''

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'yandex_mystem'
  gem.require_paths = %w(lib)
  gem.version       = YandexMystem::VERSION

  gem.add_dependency 'oj', '~> 2.11'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rake', '~> 10.1'
end
