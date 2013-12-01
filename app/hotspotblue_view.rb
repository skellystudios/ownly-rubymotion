class HotspotBlueView < UIView

  def init
  end

  def initWithFrame(new_frame)
    super

    self.frame = new_frame
    self.opaque = false

    self
  end

  def drawRect(rect)
    UIColor.blueColor.setFill
    UIRectFill(rect)
  end
  
end
