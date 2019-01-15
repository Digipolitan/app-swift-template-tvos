workspace 'AppSwiftTemplate_tvOS.xcworkspace'

abstract_target 'Common' do
	use_frameworks!

	pod 'DependencyInjectorObjectMapper'
	pod 'AlamofireLogging'
	pod 'RuntimeEnvironment'
	pod 'LocalizationToolkitObjectMapper'

	target 'Domain' do
		project 'Domain.xcodeproj'
		platform :tvos, '9.0'
	end

    target 'AppSwiftTemplate_tvOS' do
        project 'AppSwiftTemplate_tvOS.xcodeproj'
        platform :tvos, '9.0'

        pod 'Monet'
        pod 'SessionKit'
        pod 'SplashKit'
        pod 'Roadblock'
    end
end
