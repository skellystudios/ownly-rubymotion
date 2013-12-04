include SugarCube::CoreGraphics

class AppDelegate

  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    root = RootViewController.alloc.init
    nav_controller = UINavigationController.alloc.initWithRootViewController(root)
    
    image = UIImage.imageNamed('navbar.png')
    nav_controller.navigationBar.setBackgroundImage(image, forBarMetrics:UIBarMetricsDefault)

    @window.rootViewController = nav_controller
    @window.makeKeyAndVisible
    true
  end
end
