require 'rake/testtask'

Rake::TestTask.new(:test_railsless) do |t|
  t.libs << "test"
  t.test_files = FileList['test/railsless/*_test.rb']
  t.verbose = true
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/functional/*_test.rb', 'test/unit/**/*_test.rb']
  t.verbose = true
end

task :default => [:test_railsless, :test]
