#
# Be sure to run `pod lib lint SwiftMoji.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "SwiftMoji"
s.version          = "0.5.0"
s.summary          = "A Simple Swift String Extension"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = <<-DESC
Simple Swift String Extension
It provides method like.. 'camelized', 'snakecased' and so on...
DESC

s.homepage         = "https://github.com/tikidunpon/SwiftMoji"
s.license          = 'MIT'
s.author           = { "koichi" => "tanakakoichi256@gmail.com" }
s.source           = { :git => "https://github.com/tikidunpon/SwiftMoji.git", :tag => s.version.to_s }

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'SwiftMoji/Classes/**/*'

s.swift_version = '5.0'

end
