# frozen_string_literal: true

Dir.glob(File.join('lib/tasks/**/*.rake')).each { |file| load file }

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test
