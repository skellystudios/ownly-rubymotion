class DiscoveryController < UIViewController
  def loadView
    super
    bounds = UIScreen.mainScreen.bounds
    nav_height = UIApplication.sharedApplication.delegate.window.rootViewController.navigationBar.frame.height

    self.view = DiscoveryView.alloc.initWithFrame(Rect(0, nav_height, bounds.width, bounds.height - nav_height))
  end

  def viewDidLoad
    super
    self.view.setBackgroundColor("#f3f6ef".uicolor)
    self.view.setCategory(@category)
  end

  def initWithCategory(category)
    @category = category
    init
  end
end
