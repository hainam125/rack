require 'rack'
require 'thin'
require 'rack/lobster'

lobster = Rack::Lobster.new

protected_lobster = Rack::Auth::Basic.new(lobster) do |username, password|
	password == '123456'
end

protected_lobster.realm = 'nam123'
pretty_protected_lobster = Rack::ShowStatus.new(Rack::ShowExceptions.new(protected_lobster))

Rack::Handler::Thin.run pretty_protected_lobster, Port: 3000