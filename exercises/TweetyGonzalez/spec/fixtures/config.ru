FIXTURE_ROOT = File.expand_path("../", __FILE__)

app = lambda do |env|
  request = Rack::Request.new(env)
  if request.path == '/search.atom' && request.content_type == 'application/atom+xml'
    case request.params['q']
    when 'tweety'
      body = File.open(File.join(FIXTURE_ROOT, 'tweety.xml'))
    else
      body = ""
    end
    [200, { 'Content-Type' => 'application/xml' }, body]
  else
    [404, { 'Content-Type' => 'text/plain' }, "Not Found"]
  end
end

run(app)
