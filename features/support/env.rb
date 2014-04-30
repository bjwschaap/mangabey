# Generated by cucumber-sinatra. (2014-04-30 15:01:46 +0200)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/mangabey.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Mangabey::Server

class MangabeyWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  MangabeyWorld.new
end
