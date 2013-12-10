class WebOwnViewController < UIViewController
  def initWithURL(url)
    init
    @url = url
    self
  end

  def loadView
    super
    bounds = UIScreen.mainScreen.bounds
    nav_height = UIApplication.sharedApplication.delegate.window.rootViewController.navigationBar.frame.height
    self.view = UIWebView.alloc.initWithFrame(Rect(0, nav_height, bounds.width, bounds.height - nav_height))

    self
  end

  def viewDidLoad
    super
    self.view.setBackgroundColor("#f3f6ef".uicolor)
    self.view.loadRequest(NSURLRequest.requestWithURL(@url.nsurl))
    self
  end
end

