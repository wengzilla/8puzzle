require 'rake/testtask'

task :test do
  $LOAD_PATH.unshift('.', 'tests')
  Dir.glob('./tests/**/*_test.rb') { |f| require f }
end

task :default => [:test]