Pod::Spec.new do |s|
  s.name             = 'NibOwner'
  s.version          = '1.0.0'
  s.swift_version    = '4.2'
  s.summary          = 'Utility for creating view from NIB'

  s.description      = <<-DESC
                       NIB files offer a convenient way to build view hierarchies. This lib provides a protocol that adds a factory function to the view class.
                       DESC

  s.homepage         = 'https://github.com/johannesd/NibOwner'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Johannes Dörr' => 'mail@johannesdoerr.de' }
  s.source           = { :git => 'https://github.com/johannesd/NibOwner.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/johdoerr'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NibOwner/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
