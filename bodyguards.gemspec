require_relative 'lib/bodyguards/version'

Gem::Specification.new do |s|
  s.name = 'bodyguards'
  s.version = Bodyguards::VERSION
  s.summary = 'Flexible permission management'
  s.description = 'Write bodyguard classes for permission management with a minimal DSL'
  s.homepage = 'https://github.com/sbilharz/bodyguards'
  s.files = Dir['lib/**/*.rb']
  s.authors = ['Stefan Bilharz']
  s.email = 'sbilharz@heilmannsoftware.de'
  s.license = 'MIT'
end
