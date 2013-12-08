class HeaderView < UIView
  def initWithFrame(frame)
    super

    label = UILabel.alloc.initWithFrame(frame)
    label.text = "OWNLY"
    label.textColor = "#5783c2".uicolor
    label.textAlignment = NSTextAlignmentCenter
    label.font = :helvetica.uifont(30)

    self << label

    self
  end

  def drawRect(rect)
    [236, 236, 236].uicolor.setFill
    UIRectFill(rect)
  end
end
