class DrawerFrontView < UIView

  attr_reader :label

  def initWithFrame(frame)
    super

    # @initial_frame = Rect(frame.x, frame.y, frame.width, frame.height)

    offImage = UIImage.imageNamed("heart_drawer_off.png")
    @offImageView = UIImageView.alloc.initWithImage(offImage)
    @offImageView.setFrame(CGRectMake(0,0,self.frame.size.width,self.frame.size.height))
    self.addSubview @offImageView

    onImage = UIImage.imageNamed("heart_drawer_on.png")
    @onImageView = UIImageView.alloc.initWithImage(onImage)
    @onImageView.setFrame(CGRectMake(0,0,self.frame.size.width,self.frame.size.height))
    self.addSubview @onImageView

  end

  def open()
    @onImageView.fade_in
  end

  def close()
    @onImageView.fade_out
  end

#   def animate(placardY)
# #
# #    puts "1"
# #
#     max_width = @initial_frame.width + 16
# #    max_height = @initial_frame.height + 14
# #
# #    placardStartY = self.superview.frame.center.y - self.superview.y_shift
# #    placardFinalY = @initial_frame.y + @initial_frame.height / 2
# #
# #    if placardY >= placardFinalY
# #      self.frame = Rect(frame.x, frame.y, max_width, max_height)
# #    else
# #      percentChange = (placardY - placardStartY) / (placardFinalY - placardStartY)
# #      self.frame = Rect(frame.x, frame.y,
# #                        @initial_frame.width + (percentChange * (max_width - @initial_frame.width)),
# #                        @initial_frame.height + (percentChange * (max_height - @initial_frame.height)))
# #    end

#     # glow on completion option

# #    me = self
# #
# #    UIView.transitionWithView(me, duration: 0.25, options: UIViewAnimationOptionCurveLinear, animations: lambda do
# #      self.frame = Rect(0, frame.y, max_width, frame.height)
# #    end,
# #    completion: lambda do |x|
# #      UIView.transitionWithView(me, duration: 0.25, options: UIViewAnimationOptionCurveLinear, animations: lambda do
# #        self.frame = @initial_frame
# #      end, completion: nil)
# #    end)

# #    lyr = CAShapeLayer.layer
# #    lyr.frame = self.frame
# #    lyr.fillColor = :black.uicolor.CGColor
# #    lyr.lineWidth = 3.8;
# #    lyr.strokeColor = :black.uicolor.CGColor
# #    self.layer.addSublayer(lyr)
# #
# #    basicAnimation = CABasicAnimation.animationWithKeyPath("fillColor")
# #    basicAnimation.toValue = UIColor.clearColor.CGColor
# #    basicAnimation.duration = 2
# #    basicAnimation.repeatCount = 1
# #    basicAnimation.autoreverses = true
# #    self.layer.addAnimation(basicAnimation, forKey: "flashStrokeColor")
#   end

end
