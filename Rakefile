require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.libs << "test"
  t.test_files = FileList['test/tests/**/*.rb']
end

task :build do
  system 'gem build gadfly.gemspec'
  `rm -rf build`
  `mkdir build`
  `mv *.gem build`
end