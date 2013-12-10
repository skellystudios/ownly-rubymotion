class DrawerFrontView < UIView

  attr_reader :label

  def initWithFrame(frame)
    super

    @initial_frame = Rect(frame.x, frame.y, frame.width, frame.height)

    self
  end

  def animate(placardY)
#
#    puts "1"
#
    max_width = @initial_frame.width + 16
#    max_height = @initial_frame.height + 14
#
#    placardStartY = self.superview.frame.center.y - self.superview.y_shift
#    placardFinalY = @initial_frame.y + @initial_frame.height / 2
#
#    if placardY >= placardFinalY
#      self.frame = Rect(frame.x, frame.y, max_width, max_height)
#    else
#      percentChange = (placardY - placardStartY) / (placardFinalY - placardStartY)
#      self.frame = Rect(frame.x, frame.y,
#                        @initial_frame.width + (percentChange * (max_width - @initial_frame.width)),
#                        @initial_frame.height + (percentChange * (max_height - @initial_frame.height)))
#    end

    # glow on completion option

#    me = self
#
#    UIView.transitionWithView(me, duration: 0.25, options: UIViewAnimationOptionCurveLinear, animations: lambda do
#      self.frame = Rect(0, frame.y, max_width, frame.height)
#    end,
#    completion: lambda do |x|
#      UIView.transitionWithView(me, duration: 0.25, options: UIViewAnimationOptionCurveLinear, animations: lambda do
#        self.frame = @initial_frame
#      end, completion: nil)
#    end)

#    lyr = CAShapeLayer.layer
#    lyr.frame = self.frame
#    lyr.fillColor = :black.uicolor.CGColor
#    lyr.lineWidth = 3.8;
#    lyr.strokeColor = :black.uicolor.CGColor
#    self.layer.addSublayer(lyr)
#
#    basicAnimation = CABasicAnimation.animationWithKeyPath("fillColor")
#    basicAnimation.toValue = UIColor.clearColor.CGColor
#    basicAnimation.duration = 2
#    basicAnimation.repeatCount = 1
#    basicAnimation.autoreverses = true
#    self.layer.addAnimation(basicAnimation, forKey: "flashStrokeColor")
  end

  def drawRect(rect)
    [96, 145, 225].uicolor.setFill
    UIRectFill(rect)

    [255, 255, 255].uicolor.setFill
    UIRectFill(Rect(rect.x, rect.y + rect.height - 20, rect.width, 20))


    @label = UILabel.alloc.initWithFrame(Rect(rect.x, rect.y , rect.width, rect.height - 20))
    @label.text = "DRAWER"
    @label.textColor = :white.uicolor
    @label.textAlignment = NSTextAlignmentCenter
    @label.font = UIFont.fontWithName 'Cocon', size: 30

    self << @label
  end
end
