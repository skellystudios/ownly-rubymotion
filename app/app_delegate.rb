include SugarCube::CoreGraphics

class AppDelegate

  attr_reader :window, :PLACARD_FILES

  def self.PLACARD_FILES
    [
    "placards/C10.png",
    "placards/C11.png",
    "placards/C12.png",
    "placards/C13.png",
    "placards/C4.png",
    "placards/C5.png",
    "placards/C6.png",
    "placards/C7.png",
    "placards/C8.png",
    "placards/C9.png",
    "placards/M11.png",
    "placards/M15.png",
    "placards/M17.png",
    "placards/M22.png",
    "placards/M23.png",
    "placards/M27.png",
    "placards/M29.png",
    "placards/M30.png",
    "placards/M32.png",
    "placards/M33.png",
    "placards/M35.png",
    "placards/M36.png",
    "placards/M37.png",
    "placards/M38.png",
    "placards/M39.png",
    "placards/M43.png",
    "placards/M45.png",
    "placards/M47.png",
    "placards/M49.png",
    "placards/M51.png",
    "placards/M53.png",
    "placards/M54.png",
    "placards/M55.png",
    "placards/M56.png",
    "placards/M58.png",
    "placards/M72.png",
    "placards/M79.png",
    "placards/M80.png",
    "placards/M81.png",
    "placards/M90.png",
    "placards/M91.png",
    "placards/W10.png",
    "placards/W1.jpg",
    "placards/W1.png",
    "placards/W2.png",
    "placards/W3.png",
    "placards/W4.png",
    "placards/W5.png",
    "placards/W6.png",
    "placards/W7.png",
    "placards/W8.png"
    ]
  end

  def self.saved_placards
    #@@saved_placards
    @@saved_placards = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  def self.saved_placards=(placards)
    @@saved_placards = placards
  end

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
