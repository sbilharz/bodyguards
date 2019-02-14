require_relative 'lib/bodyguards/version'

Gem::Specification.new do |s|
  s.name = 'bodyguards'
  s.version = Bodyguards::VERSION
  s.summary = 'Flexible permission management'
  s.description = 'Write bodyguard classes for permission management with a minimal DSL'
  s.files = ['lib/bodyguards.rb', 'lib/bodyguards/base.rb', 'lib/bodyguards/rule_set.rb', 'lib/bodyguards/rule.rb']
  s.authors = ['Stefan Bilharz']
  s.email = 'sbilharz@heilmannsoftware.de'
  s.license = 'MIT'
end
