Pod::Spec.new do |s|
  s.name = 'Inspire'
  s.version = "1.0.3"
  s.license = 'MIT'
  s.summary = '主题模块，用于提供UI常量配置。'
  s.homepage = "http://xaoxuu.com"
  s.authors = { 'xaoxuu' => 'xaoxuu@gmail.com' }
  s.source = { :git => "https://github.com/xaoxuu/Inspire.git", :tag => "#{s.version}", :submodules => false}
  s.ios.deployment_target = '8.0'

  s.source_files = 'Inspire/**/*.swift'
  # s.resource_bundles = { 'Inspire' => ['Inspire/*.{xcassets,strings,xml,storyboard,xib,xcdatamodeld,gif,lproj}'] }

 # s.swift_version = '4.2'
  s.requires_arc = true


end
