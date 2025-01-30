# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BoilerPlateSUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for BoilerPlateSUI
  pod 'HyperSDK', '2.2.2'
  
end

post_install do |installer|
  fuse_path = "./Pods/HyperSDK/Fuse.rb"
  clean_assets = true # Pass true to re-download all the assets
  if File.exist?(fuse_path)
    if system("ruby", fuse_path.to_s, clean_assets.to_s)
    end
  end
end
 
