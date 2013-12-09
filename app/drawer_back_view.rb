class DrawerBackView < UIView

  def self.instance
    @@instance
  end

  def initWithFrame(frame)
    super(frame)

    # 598 x 108
    # 68 105 162

    @@instance = self

    self
  end

  def drawRect(rect)
    [68, 105, 162].uicolor.setFill
    UIRectFill(rect)
  end
end

