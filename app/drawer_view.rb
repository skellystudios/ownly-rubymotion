class DrawerView < UIScrollView
  def initWithFrame(frame)
    super

    self.delegate = self

    self.setBackgroundColor("#f3f6ef".uicolor)

    # get the list of placard files that we have saved thus far
    saved_placards = AppDelegate.saved_placards

    self.setContentSize(Size(frame.width, 5 + ((saved_placards.length + 1) / 2) * (bounds.height / 3 + 20)))


    @placard_views = []
    j = 0
    for i in saved_placards
      if j % 2 == 0
        x = 6
      else
        x = bounds.width / 2 + 4
      end

      y = 5 + (j / 2) * (bounds.height / 3 + 18)

      frame = Rect(x, y, bounds.width / 2 - 10, bounds.height / 3 + 10)
      placard = DrawerPlacard.alloc.initWithFrame(frame, withImage: AppDelegate.PLACARD_FILES[i].keys[0], andLink: AppDelegate.PLACARD_FILES[i].values[0])
      self << placard

      @placard_views.push(placard)

      j += 1
    end

    self
  end

  def touchesBegan(touches, withEvent: event)
    if @isScrolling
      return
    end

    touch = touches.anyObject

    for placard_view in @placard_views
      if touch.view == placard_view || touch.view.isDescendantOfView(placard_view)
        # push a new web view with placard_view's link
        UIApplication.sharedApplication.delegate.window.rootViewController.pushViewController(WebOwnViewController.alloc.initWithURL(placard_view.link), animated: true)
      end
    end
  end

  def scrollViewDidScroll(sender)
  end

  def viewDidLoad
  end

  def drawRect(rect)
  end

  def scrollViewWillBeginDragging(scrollView)
    @isScrolling = true
  end

  def scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    if !decelerate
      @isScrolling = false
    end
  end

  def scrollViewDidEndDecelerating(scrollView)
    @isScrolling = false
  end

  def scrollViewDidScrollToTop(scrollView)
    @isScrolling = false
  end

  def scrollViewDidEndScrollingAnimation(scrollView)
    @isScrolling = false
  end
end
