myProjectName = "Test Acroforms"
source 'https://github.com/CocoaPods/Specs.git'
project "#{myProjectName}.xcodeproj"
platform :ios, '10.0'

target myProjectName do
	use_frameworks!
	pod 'ILPDFKit'
end

post_install do |installer|
	installer.pods_project.targets.each do |target| 
		target.build_configurations.each do |config|
			# config.build_settings['SWIFT_VERSION'] = "3.0"
			config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = ['$(inherited)']      
			if config.name == 'Debug'
				config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDEBUG'
				config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
			else
				config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'					
			end
		end
	end
end
