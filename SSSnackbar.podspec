#
# Be sure to run `pod lib lint SSSnackbar.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SSSnackbar"
  s.version          = "0.1.0"
  s.summary          = "An iOS implementation of the Google Material Design's Snackbar UI element, as used extensively in Android as well as some Google iOS apps such as Gmail"
  s.description      = <<-DESC
                        A snackbar is a way to display an actionable alert to the user.

                        A common example usage is to provide the user with a 5-10 second grace period during which they can undo some change they have performed, such as deleting or achiving some data.

                        Snackbars are used extensively in recent versions of Android and Google's iOS apps.

                       DESC
  s.homepage         = "https://github.com/stonesam92/SSSnackbar"
  # s.screenshots     = "http://i.imgur.com/Z5QWAJW.jpg", "http://i.imgur.com/bud0MB4.jpg"
  s.license          = 'MIT'
  s.author           = { "Sam Stone" => "stonesam92@gmail.com" }
  s.source           = { :git => "https://github.com/stonesam92/SSSnackbar.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/CmdShiftN'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SSSnackbar' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
