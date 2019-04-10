#
#  Be sure to run `pod spec lint locus.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "locus"
  s.version      = "1.5"
  s.summary      = "track your code on debug"
  s.platform     = :ios, "7.0"
  
  s.description = %{
      track your code on debug
    }
                   
  s.homepage     = "https://github.com/hzfanfei/locus.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fanfei" => "hzfanfei@163.com" }
  s.source       = { :git => "https://github.com/hzfanfei/locus.git", :tag => s.version }
  s.source_files = "locus/locus/*.{h,m,c}"
  s.public_header_files = "locus/locus/*.h"
  s.requires_arc = true
  
end
