
Pod::Spec.new do |s|

  s.name         = "MCBouncyButton"
  s.version      = "1.0.0"
  s.summary      = "An iOS bouncy button with Pop."
  s.description  = <<-DESC
                    MCBouncyButton is a subclass of UIButton that leverages Pop to pleasantly bounce due to user interaction.
                    Supports preconfigured styles (default and selected) and you can add your own.
                   DESC
  s.homepage     = "https://github.com/Shrugs/MCBouncyButton"
  s.screenshots  = "https://raw.githubusercontent.com/Shrugs/MCBouncyButton/master/mcbouncybutton.gif"
  s.license      = "MIT"
  s.author             = { "Matt Condon (Shrugs)" => "m@cond.in" }
  s.social_media_url   = "http://twitter.com/mattgcondon"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/Shrugs/MCBouncyButton.git", :tag => "1.0.0"}
  s.source_files  = "MCBouncyButton/*.{h,m}"

  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency "pop", "~> 1.0"

end
