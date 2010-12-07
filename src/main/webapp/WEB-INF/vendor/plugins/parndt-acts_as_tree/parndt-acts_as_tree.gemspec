Gem::Specification.new do |s|
  s.name              = %q{parndt-acts_as_tree}
  s.version           = %q{1.2.5}
  s.description       = %q{Use this acts_as extension if you want to model a tree structure by providing a parent association and a children
  association.}
  s.date              = %q{2010-08-31}
  s.summary           = %q{acts_as_tree plugin.}
  s.homepage          = %q{http://philiparndt.name}
  s.authors           = ["David Heinemeier Hansson", "Philip Arndt", "Others"]
  s.require_paths     = %w(lib)

  s.files             = [
    'init.rb',
    'lib',
    'lib/active_record',
    'lib/active_record/acts',
    'lib/active_record/acts/tree.rb',
    'lib/acts_as_tree.rb',
    'lib/gemspec.rb',
    'rails',
    'rails/init.rb',
    'Rakefile',
    'readme.textile',
    'test',
    'test/acts_as_tree_test.rb',
    'VERSION'
  ]
  s.test_files        = [
    'test/acts_as_tree_test.rb'
  ]
end
