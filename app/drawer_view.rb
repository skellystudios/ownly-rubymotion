class DrawerView < UIScrollView
  def initWithFrame(frame)
    super

    # get the list of placard files that we have saved thus far
    saved_placards = AppDelegate.saved_placards

    self.setContentSize(Size(frame.width, frame.height + (saved_placards.length / 2 * frame.height / 3)))

    j = 0
    for i in saved_placards
      frame = Rect(0, 0, bounds.width / 2 - 10, bounds.height / 3 + 10)
      placard = DrawerPlacard.alloc.initWithFrame(frame, withImage: AppDelegate.PLACARD_FILES[i], andLink: "http://www.google.com")
      self << placard
      j += 1
      break
    end

    self
  end

  def viewDidLoad
  end

  def drawRect(rect)
  end

end
