#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint meiqia_sdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'meiqia_sdk_flutter'
  s.version          = '0.0.1'
  s.summary          = "美洽官方 SDK for iOS"
  s.description      = "美洽官方的 Flutter SDK"
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/Meiqia/MeiqiaSDK-Flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { "zhangshunxing" => "zhangshunxing@meiqia.com" }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Meiqia', '>= 3.8.4'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
