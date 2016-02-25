Pod::Spec.new do |s|
  s.name             = "Validated"
  s.version          = "1.0.0"
  s.summary          = "A Swift μ-Library for Somewhat Dependent Types"
  s.description      = <<-DESC
                        Validated is a μ-library (~50 Source Lines of Code) that allows you make better use of Swift's type system
                        by providing tools for easily generating new types with built-in guarantees.
                        DESC
  s.homepage         = "https://github.com/Ben-G/Validated"
  s.license          = { :type => "MIT", :file => "LICENSE.md" }
  s.author           = { "Benjamin Encz" => "me@benjamin-encz.de" }
  s.social_media_url = "http://twitter.com/benjaminencz"
  s.source           = { :git => "https://github.com/Ben-G/Validated.git", :tag => s.version.to_s }
  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true
  s.source_files     = 'Validated/**/*.swift'
end
