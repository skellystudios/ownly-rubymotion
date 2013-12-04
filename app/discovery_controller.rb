class DiscoveryController < UIViewController
  def loadView
    super
    bounds = UIScreen.mainScreen.bounds
    bounds.height -= UIApplication.sharedApplication.delegate.window.rootViewController.navigationBar.frame.height

    self.view = DiscoveryView.alloc.initWithFrame(bounds)
  end

  def viewDidLoad
    super
    self.view.setBackgroundColor(UIColor.whiteColor)
  end
end
