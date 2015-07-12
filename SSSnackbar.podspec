Pod::Spec.new do |s|
  s.name             = "SSSnackbar"
  s.version          = "0.1.0"
s.summary          = "An iOS implementation of the Material Design Snackbar component; a stylish actionable alert."
  s.description      = <<-DESC
                        Snackbars are a Android UI component which present a stylish, actionable alert to the user. Google also uses their own iOS snackbar implementation in some of their iOS apps, such as Gmail.

                        Snackbar's are useful for presenting a brief message to the user which they can then act on. A common usage pattern is to display a snackbar after a user has performed some destructive action, providing the user with a grace period during which they can undo this action.

                       DESC
  s.homepage         = "https://github.com/stonesam92/SSSnackbar"
  s.screenshots     = "http://i.imgur.com/Z5QWAJW.jpg", "http://i.imgur.com/bud0MB4.jpg"
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
