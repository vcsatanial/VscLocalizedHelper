Pod::Spec.new do |spec|
  spec.name             = 'VscLocalizedHelper'
  spec.ios.deployment_target = '7.0'
  spec.version          = '1.0.0'
  spec.summary          = '国际化自定义'
  spec.description      = <<-DESC
			自定义国际化的语言
                       DESC
  spec.homepage         = 'https://github.com/vcsatanial/VscLocalizedHelper'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'VincentSatanial' => '116359398@qq.com' }
  spec.source           = { :git => 'https://github.com/vcsatanial/VscLocalizedHelper.git', :tag => spec.version }
  
  spec.source_files = 'VscLocalizedHelper/*.{h,m}'
  spec.requires_arc = true
end
