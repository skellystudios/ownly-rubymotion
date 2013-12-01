include SugarCube::CoreGraphics

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = DiscoveryController.new
    @window.makeKeyAndVisible
    true
  end
end
