require 'rubocop/rake_task'
require 'rspec/core/rake_task'

desc 'Style checking using rubocop'
RuboCop::RakeTask.new(:style) do |task|
  task.fail_on_error = false
end

desc 'RSpec tests'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = Dir.glob('spec/**/*_spec.rb')
  task.rspec_opts = '--format documentation'
end

task default: [:spec, :style]
