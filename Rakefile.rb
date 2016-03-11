require 'rspec/core/rake_task'

task default: %w(spec)

Rspec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec'
end
