use Rack::Static,
	urls: 				Dir.glob("public/*").map{ |fn| fn.gsub(/public/, '')},
	root: 				"public",
	index: 				"index.html"
	#header_rules: [[:all, {'Cache-Control' => 'public, max-age=3600'}]]

#headers = {'Content-Type' => 'text/html', 'Content-Length' => '9'}
app = lambda do |env|
	[
		200,
		{
			'Content-Type'  => 'text/html'
		},
		File.open('public/index.html', File::RDONLY)
	]
end

run app