require "rake/testtask"

Rake::Task[:test].clear

desc "Run suite of tests"
task :test => ["db:migrate", "test:features", "test:unit"]

namespace :test do
  "Run feature tests"
  Rake::TestTask.new(:features) do |t|
    t.libs << "test"
    t.pattern = "test/features/*_feature.rb"
  end
  "Run feature tests"
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.pattern = "test/models/*_test.rb"
  end
end

task :default => :test
