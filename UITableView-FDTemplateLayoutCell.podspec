
Pod::Spec.new do |s|

  s.name         = "UITableView-FDTemplateLayoutCell.swift"
  s.version      = "0.9.0"
  s.summary      = "GesturePassword is a simple gesture password written in Swift"
  s.homepage     = "https://github.com/huangboju/UITableView-FDTemplateLayoutCell.swift"
  s.license      = "MIT"
  s.author             = { "huangboju" => "529940945@qq.com" }
  s.platform     = :ios,'8.0'
  s.source       = { :git => "https://github.com/huangboju/UITableView-FDTemplateLayoutCell.swift.git", :tag => "#{s.version}" }
  s.source_files  = "Classes/**/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end
