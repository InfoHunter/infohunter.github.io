use ::Rack::Static, 
  :root => "_site",
  :urls => %w[/]

run lambda { [404, {'Content-Type' => 'text/plain'}, ['Not Found']]}