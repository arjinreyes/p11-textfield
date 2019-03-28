# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'p11-textfield' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for p11-textfield

  target 'p11-textfieldTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Mockingjay', '2.0.1'
    pod 'Nimble', '7.3.1'
    pod 'Quick', '1.3.2'
    pod 'Moya/RxSwift', '~> 12.0'
  end

pod 'SnapKit'

post_install do |installer|         
    installer.pods_project.build_configurations.each do |config|             
	config.build_settings.delete('CODE_SIGNING_ALLOWED')             
	config.build_settings.delete('CODE_SIGNING_REQUIRED')             
	config.build_settings['ENABLE_BITCODE'] = 'NO'         
    	config.build_settings['SWIFT_VERSION'] = '4.2'         
    end     
            
    installer.pods_project.targets.each do |target|             
	target.build_configurations.each do |config|                     
	    config.build_settings['SWIFT_VERSION'] = '4.2'          
	end           
    end
end

end

