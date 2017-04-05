require 'rack'
require 'thin'

class Decorator
	def initialize(app)
		@app = app
	end

	def call(env)
		status, headers, body = @app.call(env)
		new_body = "-------------Header-------------<br/>"
		puts body.inspect
		body.each{|s| new_body << s}
		new_body << "<br/>-----------Footer---------------"
		headers["Content-Type"]   = 'text/html'
		headers["Content-Length"] = new_body.bytesize.to_s
		[status, headers, [new_body]]
	end
end

rack_app = lambda do |env|
	request  = Rack::Request.new(env)
	response = Rack::Response.new

	if request.path_info == '/hello'
		response.write 'You say hello'
		client = request['client']
		response.write "from #{client}" if client
	else
		response.write "You need to provide client info"
	end
	response.finish
end

builder = Rack::Builder.new do
	use Rack::ContentLength
	use Decorator
	run rack_app
end

Rack::Handler::Thin.run Decorator.new(builder), Port: 3000