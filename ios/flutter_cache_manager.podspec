#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_cache_manager'
  s.version          = '1.1.3'
  s.summary          = 'Flutter  plugin'
  s.description      = <<-DESC
A Flutter plugin for getting commonly used locations on the filesystem.
Downloaded by pub (not CocoaPods).
                       DESC
  s.homepage         = 'https://github.com/flutter/plugins'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Flutter Dev Team' => 'gshzyfx@163.com' }
  s.source           = { :http => 'https://github.com/gs01md/flutter_cache_manager' }
  s.documentation_url = 'https://github.com/gs01md/flutter_cache_manager'
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end

