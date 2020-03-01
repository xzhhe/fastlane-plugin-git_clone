source('https://rubygems.org')

gemspec

gem('pry')
gem('bundler')
gem('rspec')
gem('rspec_junit_formatter')
gem('rake')
gem('rubocop')
gem('rubocop-require_tools')
gem('simplecov')
gem('fastlane')

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
