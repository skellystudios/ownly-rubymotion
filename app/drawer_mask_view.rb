class DrawerMaskView < UIView

  def self.instance
    @@instance
  end

  def initWithFrame(frame)
    super(frame)
    @@instance = self
    self
  end

  def drawRect(rect)
    :white.uicolor.setFill
    UIRectFill(rect)
  end
end

