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
  s.version          = "1.0.0"
  s.summary          = "An iOS implementation of the Snackbar concept, as extensively in Android as well as some Google iOS apps such as GMail"
  s.description      = <<-DESC
                        A snackbar is a way to display an actionable alert to the user.

                        A common example usage is to allow the user a 5-10 second period to undo the deletion of some data.

                        Snackbars are used extensively in recent versions of Android and Google's iOS apps.

                        This imitation mimicks Snackbars as they are presented in the iOS Gmail app.
                       DESC
  s.homepage         = "https://github.com/stonesam92/SSSnackbar"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Sam Stone" => "stonesam92@gmail.com" }
  s.source           = { :git => "https://github.com/stonesam92/SSSnackbar.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SSSnackbar' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
