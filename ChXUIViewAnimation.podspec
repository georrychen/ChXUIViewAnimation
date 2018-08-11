 Pod::Spec.new do |s|
 s.name         = "ChXUIViewAnimation"
 s.version      = "1.0.2"
 s.ios.deployment_target = '8.0'
 s.summary      = "简介"
 s.homepage     = "https://github.com/sunrisechen007"
 s.license      = "MIT"
 s.author       = { "xuchen" => "2235037295@qq.com" }
 s.source       = { :git => 'https://github.com/sunrisechen007/ChXUIViewAnimation.git', :tag =>    s.version}
 s.requires_arc = true
 s.source_files = 'ChX_ViewAnimation/*'
 #依赖库，不能依赖未发布的库
 #s.dependency = 'AFNetworking' , 'SDWebImage'
end
