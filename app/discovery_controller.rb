class DiscoveryController < UIViewController
  def loadView
    super
    self.view = DiscoveryView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def viewDidLoad
    super
    self.view.setBackgroundColor(UIColor.whiteColor)
    self.view.setCategory(@category)
  end

  def initWithCategory(category)
    @category = category
    init
  end
end
