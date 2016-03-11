require 'rspec/core/rake_task'

task default: %w(spec)

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec'
end
