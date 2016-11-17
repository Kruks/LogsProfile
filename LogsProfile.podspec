#
#  Be sure to run `pod spec lint LogsProfile.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LogsProfile"
  s.version      = "1.0.0"
  s.summary      = "LogsProfile."
  s.description  = "LogsProfile for logging errors."
  s.homepage     = "https://github.com/"
  s.license      = "MIT"
  s.author             = "Kahuna"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Kruks/LogsProfile.git", :tag => "1.0.0" }
  s.source_files  = "LogsProfile", "LogsProfile/**/*.{h,m,swift}"
end
