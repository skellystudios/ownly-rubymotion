class DiscoveryView < UIView
  
  @orig_touch_point = nil

  attr_reader :orig_touch_point, :placards

  def initWithFrame(frame)
    if super
      screen = UIScreen.mainScreen.bounds
      @hotspot_view_red = HotspotRedView.alloc.initWithFrame(Rect(0, 0, screen.width, screen.height / 6))
      self << @hotspot_view_red

      @hotspot_view_blue = HotspotBlueView.alloc.initWithFrame(Rect(0, screen.height - screen.height / 6 - 64, screen.width, screen.height / 6))
      self << @hotspot_view_blue

      @placards = []
      for i in 0..4
        placard_view = PlacardView.alloc.init
        placard_view.center = CGPointMake(self.center.x,self.center.y - 32)
        placard_view.transform_equals(CGAffineTransformIdentity)
        @placards.unshift(placard_view)
        self << placard_view
      end
    end
    self
  end

  def setCategory(category)
    @categoryLabel = UITextField.alloc.initWithFrame([[10, 90], [80, 30]])
    @categoryLabel.borderStyle = UITextBorderStyleNone
    # p category
    @categoryLabel.text = category
    self.addSubview(@categoryLabel)
  end
  
  def touchesBegan(touches, withEvent: event)
    # We only support single touches, so anyObject retrieves just that touch from touches
    touch = touches.anyObject

    # Only move the placard view if the touch was in the placard view
    if touch.view == @placards[0]
      # Animate the first touch
      animateFirstTouchAtPoint(touch.locationInView(@placards[0]))
    end
  end

  def touchesMoved(touches, withEvent: event)
    touch = touches.anyObject

    # If the touch was in the @placards[0], move the @placards[0] to its location
    if touch.view == @placards[0]
      location = touch.locationInView(self)

      @placards[0].center = Point(location.x - @orig_touch_point.x + (@placards[0].frame[1].width / 2), location.y - @orig_touch_point.y + (@placards[0].frame[1].height / 2))
    end
  end
    
  def touchesEnded(touches, withEvent: event)
    touch = touches.anyObject

    # If the touch was in the @placards[0], bounce it back to the center
    if touch.view == @placards[0]

      screen = UIScreen.mainScreen.bounds

      if @placards[0].center.y < screen.height / 5
        # discard the placard
        animateDiscardPlacard
      elsif @placards[0].center.y > screen.height - (screen.height / 5)
        animateKeepPlacard
      else
        animatePlacardViewToCenter
      end
    end
  end
  
  @animation = nil
  def animation
    @animation
  end

  def animationDidStop(theAnimation, finished: flag)
    @animation = theAnimation
    id = theAnimation.valueForKey("id")

    case id
    when "toCenter"
    when "keep"
      @placards[0].removeFromSuperview
      @placards.delete_at(0)
    when "discard"
      @placards[0].removeFromSuperview
      @placards.delete_at(0)
    end

    if @placards.length > 0
      @placards[0].transform_equals(CGAffineTransformIdentity)
    end
    self.userInteractionEnabled = true
  end
  
  def animateFirstTouchAtPoint(touch_point)

    # find the dx/dy of the touch on the placard
    @orig_touch_point = touch_point

    # if we want to change the size of the placard when picking it up, unlikely
#    UIView.animateWithDuration(GROW_ANIMATION_DURATION_SECONDS,
#      animations: -> {
#        @placards[0].transform_equals(CGAffineTransformMakeScale(1.2, 1.2))
#      },
#      completion: -> (finished) {
#        UIView.animateWithDuration(MOVE_ANIMATION_DURATION_SECONDS,
#          animations: -> {
#            @placards[0].transform_equals(CGAffineTransformMakeScale(1.1, 1.1))
#            @placards[0].center = touch_point
#          }
#        )
#      }
#    )
  end
  
  def animatePlacardViewToCenter
    self.userInteractionEnabled = false
    welcomeLayer = @placards[0].layer

    # Create a keyframe animation to follow a path back to the center
    toCenterAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    toCenterAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = self.center.x
    midY = self.center.y - 64

    # Start the path at the placard's current location
    CGPathMoveToPoint(thePath, nil, @placards[0].center.x, @placards[0].center.y)
    CGPathAddLineToPoint(thePath, nil, midX, midY)

    toCenterAnimation.path = thePath
    toCenterAnimation.duration = animationDuration
    toCenterAnimation.setValue("toCenter", forKey: "id")

    # Create an animation group to combine the keyframe and basic animations
    theGroup = CAAnimationGroup.animation

    # Set self as the delegate to allow for a callback to reenable user interaction
    theGroup.delegate = self
    theGroup.setValue("toCenter", forKey: "id")
    theGroup.duration = animationDuration
    theGroup.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionLinear)
    theGroup.animations = [toCenterAnimation]

    # Add the animation group to the layer
    welcomeLayer.addAnimation(theGroup, forKey: :animatePlacardViewToCenter)

    # Set the placard view's center and transformation to the original values in preparation for the
    # end of the animation
    @placards[0].center = CGPointMake(self.center.x,self.center.y - 64)
    @placards[0].transform_equals(CGAffineTransformIdentity)
  end

  def animateDiscardPlacard
    self.userInteractionEnabled = false
    welcomeLayer = @placards[0].layer

    # Create a keyframe animation to follow a path back to the center
    toCenterAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    toCenterAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = self.center.x
    midY = self.center.y - 500

    # Start the path at the placard's current location
    CGPathMoveToPoint(thePath, nil, @placards[0].center.x, @placards[0].center.y)
    CGPathAddLineToPoint(thePath, nil, midX, midY)

    toCenterAnimation.path = thePath
    toCenterAnimation.duration = animationDuration
    toCenterAnimation.setValue("toCenter", forKey: "id")

    # Create an animation group to combine the keyframe and basic animations
    theGroup = CAAnimationGroup.animation

    # Set self as the delegate to allow for a callback to reenable user interaction
    theGroup.delegate = self
    theGroup.setValue("discard", forKey: "id")
    theGroup.duration = animationDuration
    theGroup.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionLinear)
    theGroup.animations = [toCenterAnimation]

    # Add the animation group to the layer
    welcomeLayer.addAnimation(theGroup, forKey: :animatePlacardViewToCenter)

    # Set the placard view's center and transformation to the original values in preparation for the
    # end of the animation
    @placards[0].center = CGPointMake(self.center.x,self.center.y - 64)
    @placards[0].transform_equals(CGAffineTransformIdentity)
  end

  def animateKeepPlacard
    self.userInteractionEnabled = false
    welcomeLayer = @placards[0].layer

    # Create a keyframe animation to follow a path back to the center
    toCenterAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    toCenterAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = self.center.x
    midY = self.center.y + 500

    # Start the path at the placard's current location
    CGPathMoveToPoint(thePath, nil, @placards[0].center.x, @placards[0].center.y)
    CGPathAddLineToPoint(thePath, nil, midX, midY)

    toCenterAnimation.path = thePath
    toCenterAnimation.duration = animationDuration
    toCenterAnimation.setValue("keep", forKey: "id")

    # Create an animation group to combine the keyframe and basic animations
    theGroup = CAAnimationGroup.animation

    # Set self as the delegate to allow for a callback to reenable user interaction
    theGroup.delegate = self
    theGroup.setValue("keep", forKey: "id")
    theGroup.duration = animationDuration
    theGroup.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionLinear)
    theGroup.animations = [toCenterAnimation]

    # Add the animation group to the layer
    welcomeLayer.addAnimation(theGroup, forKey: :animatePlacardViewToCenter)

    # Set the placard view's center and transformation to the original values in preparation for the
    # end of the animation
    @placards[0].center = CGPointMake(self.center.x,self.center.y - 64)
    @placards[0].transform_equals(CGAffineTransformIdentity)
  end
end
