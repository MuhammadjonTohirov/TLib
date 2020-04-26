Pod::Spec.new do |spec|
    spec.name = "TApps"
    spec.version = "1.5.8"
    spec.summary = "TLibs is framework which is used to develope an application in a faster speed with swift for iOS"
    spec.homepage = "https://github.com/MuhammadjonTohirov/TLib"
    spec.license = { type: 'MIT', file: 'LICENSE' }
    spec.authors = { "Mukhammadjon Tokhirov" => 'tokhirov.mukhammadjon@gmail.com' }
    spec.social_media_url = "https://www.google.com"
  
    spec.platform = :ios, "12.0"
    spec.requires_arc = true
    spec.source = { git: "https://github.com/MuhammadjonTohirov/TLib.git", tag: spec.version.to_s, submodules: true }
    spec.source_files = "TApps/**/*.swift"
    spec.swift_versions = '5.0'
    spec.framework      = 'SystemConfiguration'
    spec.ios.framework  = 'UIKit'
    spec.dependency "Kingfisher"
  end
