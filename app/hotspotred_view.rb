class HotspotRedView < UIView

  def init
  end

  def initWithFrame(new_frame)
    super

    self.frame = new_frame
    self.opaque = false

    self
  end

  def drawRect(rect)
    UIColor.redColor.setFill
    UIRectFill(rect)
  end
  
end
