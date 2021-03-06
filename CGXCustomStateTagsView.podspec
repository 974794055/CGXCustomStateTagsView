Pod::Spec.new do |s|
s.name         = "CGXCustomStateTagsView"    #存储库名称
s.version      = "1.1.3"      #版本号，与tag值一致
s.summary      = "a CGXCustomStateTagsView 固定按钮封装"  #简介
s.description  = "常用CGXCustomStateTagsView固定按钮控件状态封装，不可滑动"  #描述
s.homepage     = "https://github.com/974794055/CGXCustomStateTagsView"      #项目主页，不是git地址
s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
s.author             = { "974794055" => "974794055@qq.com" }  #作者
s.platform     = :ios, "8.0"                  #支持的平台和版本号
s.source       = { :git => "https://github.com/974794055/CGXCustomStateTagsView.git", :tag => s.version }         #存储库的git地址，以及tag值
s.requires_arc = true #是否支持ARC
s.frameworks = 'UIKit'

#需要托管的源代码路径
s.source_files  = "CGXCustomStateTagsViewOC/**/*.{h,m}"
s.public_header_files = "CGXCustomStateTagsViewOC/**/*.{h}"


end




