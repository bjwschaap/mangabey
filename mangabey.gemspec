# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','mangabey','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'mangabey'
  s.version = Mangabey::VERSION
  s.author = 'Bastiaan Schaap'
  s.email = 'b.schaap@siteminds.nl'
  s.homepage = 'https://github.com/bjwschaap/mangabey'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Mangabey is a RESTful web API for using nfsadmin'
  s.description = <<eos
                  This is a Sinatra RESTful web application that wraps the nfsadmin tool.
                  It can be used to manage NFS using REST and JSON.
eos
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
  s.require_paths << 'lib'
  s.has_rdoc = false
  s.bindir = 'bin'
  s.executables << 'mangabey'
  s.required_ruby_version = '~> 2.0'
  s.add_development_dependency('rake', '~> 10.2' )
  s.add_development_dependency('rdoc', '~> 4.1')
  s.add_development_dependency('aruba', '~> 0.5')
  s.add_development_dependency('shotgun', '0.9')
  s.add_development_dependency('passenger', '~> 4.0')
  s.add_runtime_dependency('sinatra','1.4.5')
  s.add_runtime_dependency('nfsadmin', '0.0.3')
end
