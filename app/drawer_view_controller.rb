class DrawerViewController < UIViewController
  def loadView
    super
    bounds = UIScreen.mainScreen.bounds
    nav_height = UIApplication.sharedApplication.delegate.window.rootViewController.navigationBar.frame.height
    self.view = DrawerView.alloc.initWithFrame(Rect(0, nav_height, bounds.width, bounds.height - nav_height))
    self.view.scrollEnabled = true
    self.view.canCancelContentTouches = true

    self
  end

  def viewDidLoad
    super
    self.view.setBackgroundColor("#f3f6ef".uicolor)
    self
  end
end
