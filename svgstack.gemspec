Gem::Specification.new do |s|
  s.name = 'svgstack'
  s.version = '0.1.0'
  s.summary = 'A 1st attempt at creating a stack using SVG. Under development.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/svgstack.rb']
  s.add_runtime_dependency('victor', '~> 0.2', '>=0.2.6')
  s.signing_key = '../privatekeys/svgstack.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/svgstack'
end
