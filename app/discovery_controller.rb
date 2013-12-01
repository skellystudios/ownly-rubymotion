class DiscoveryController < UIViewController
  def loadView
    super
    self.view = DiscoveryView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def viewDidLoad
    super
    self.view.setBackgroundColor(UIColor.whiteColor)
  end
end
