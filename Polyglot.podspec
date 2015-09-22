Pod::Spec.new do |s|
  s.name = 'Polyglot'
  s.version = '0.2.0'
  s.license = 'MIT'
  s.summary = 'Localize straight from the Storyboard/XIB'
  s.homepage = 'https://github.com/negusoft/polyglot'
  s.social_media_url = 'http://twitter.com/negusoft'
  s.authors = { 'Borja Lopez Urkidi' => 'blurkidi@negusoft.com' }
  s.source = { :git => 'https://github.com/negusoft/polyglot.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.ios.source_files = 'Polyglot/Source/UI*.swift'
  s.osx.source_files = 'Polyglot/Source/NS*.swift'

  s.requires_arc = true
end
