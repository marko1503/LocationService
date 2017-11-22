Pod::Spec.new do |s|
  s.name         = "LocationService"
  s.version      = "0.1"
  s.summary      = "It's a wrapper around CLLocationManager"
  s.description  = <<-DESC
    Your description here.
  DESC
  s.homepage     = "https://github.com/marko1503/LocationService.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Maksym Prokopchuk" => "maksym.prokopchuk@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/marko1503/LocationService.git.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
