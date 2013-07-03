Gem::Specification.new do |gem|
  gem.name     = 'gadfly'
  gem.version  = '0.0.2'
  gem.summary  = 'run a ruby script as an upstart daemon'
  gem.author   = 'Lihan Li'
  gem.email    = 'frankieteardrop@gmail.com'
  gem.homepage = 'http://github.com/lihanli/gadfly'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.executables << 'gadfly'
end