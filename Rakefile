# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'mvp'
  app.provisioning_profile = '/Users/adam/Desktop/ownly_app.mobileprovision' 
  app.codesign_certificate = 'iPhone Distribution: Adam CONROY (747875KKR6)' 

  app.frameworks += ['QuartzCore']

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = 'da906c36ee9fdcd4a74d65851506c719_MTQ4ODAwMDIwMTMtMTItMDMgMTA6MjU6NDUuMDM4Mzk1'
  app.testflight.team_token = 'ffd3bf34bec27f4d2279ec2bf9eb2604_MzA4MzgyMjAxMy0xMi0wMyAxMDozNzo0NS41NTMxMDY'

  app.entitlements['get-task-allow'] = false
end
