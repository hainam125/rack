require "rack"
require "thin"

rack_app = lambda do |env|
	request  = Rack::Request.new(env)
	response = Rack::Response.new

	if request.path_info == '/redirect'
		response.redirect('http://google.com')
	else
		response.write 'You are'
	end
	response.finish
end

Rack::Handler::Thin.run rack_app, Port:3000