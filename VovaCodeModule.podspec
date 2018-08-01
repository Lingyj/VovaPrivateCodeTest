#
# Be sure to run `pod lib lint VovaCodeModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VovaCodeModule"
  s.version          = '0.2.0'
  s.summary          = 'VovaCodeModule.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Yongjian Ling/VovaCodeModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yongjian Ling' => 'yjling@i9i8.com' }
  s.source           = { :git => 'https://github.com/Lingyj/VovaPrivateCodeTest.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VovaCodeModule/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VovaCodeModule' => ['VovaCodeModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnowplowTracker', '~> 0.8.0'
  s.dependency 'UICKeyChainStore', '~> 2.1.1'


  s.subspec 'VovaSubModule' do |cs|
       cs.source_files = 'VovaCodeModule/Classes/VovaSubModule/**/*'
  end

end
