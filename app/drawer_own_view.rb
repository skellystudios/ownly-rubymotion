class DrawerOwnView < UIView
  def drawRect(rect)
    [96, 145, 225].uicolor.setFill
    UIRectFill(rect)

    @label = UILabel.alloc.initWithFrame(rect)
    @label.text = "OWN"
    @label.textColor = :white.uicolor
    @label.textAlignment = NSTextAlignmentCenter
    @label.font = UIFont.fontWithName 'Cocon', size: 16

    self << @label
  end
end
