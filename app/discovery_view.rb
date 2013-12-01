class DiscoveryView < UIView
  
  @placard_view = nil
  @orig_touch_point = nil

  attr_reader :orig_touch_point, :placard_view

  def initWithFrame(frame)
    if super
      screen = UIScreen.mainScreen.bounds
      @hotspot_view_red = HotspotRedView.alloc.initWithFrame(Rect(0, 0, screen.width, screen.height / 5))
      self << @hotspot_view_red

      @hotspot_view_blue = HotspotBlueView.alloc.initWithFrame(Rect(0, screen.height - screen.height / 5, screen.width, screen.height / 5))
      self << @hotspot_view_blue

      @placard_view = PlacardView.alloc.init
      @placard_view.center = self.center
      @placard_view.rotate(2.degrees)
      self << @placard_view
    end
    self
  end
  
  def placardView
    @placard_view
  end

  def touchesBegan(touches, withEvent: event)
    # We only support single touches, so anyObject retrieves just that touch from touches
    touch = touches.anyObject

    # Only move the placard view if the touch was in the placard view
    if touch.view == placardView
      # Animate the first touch
      animateFirstTouchAtPoint(touch.locationInView(placardView))
    end
  end

  def touchesMoved(touches, withEvent: event)
    touch = touches.anyObject

    # If the touch was in the placardView, move the placardView to its location
    if touch.view == placardView
      location = touch.locationInView(self)

      placardView.center = Point(location.x - @orig_touch_point.x + (placardView.frame[1].width / 2), location.y - @orig_touch_point.y + (placardView.frame[1].height / 2))
    end
  end
    
  def touchesEnded(touches, withEvent: event)
    touch = touches.anyObject

    # If the touch was in the placardView, bounce it back to the center
    if touch.view == placardView

      screen = UIScreen.mainScreen.bounds

      if @placard_view.center.y < screen.height / 5
        UIAlertView.alert ":("
      elsif @placard_view.center.y > screen.height - (screen.height / 5)
        UIAlertView.alert ":)"
      end

      # Disable user interaction so subsequent touches don't interfere with animation
      self.userInteractionEnabled = false
      animatePlacardViewToCenter
    end
  end
  
  def animationDidStop(theAnimation, finished: flag)
    # Animation delegate method called when the animation's finished:
    # restore the transform and reenable user interaction
    placardView.transform = CGAffineTransformIdentity
    @placard_view.rotate(2.degrees)
    self.userInteractionEnabled = true
  end
  
  def animateFirstTouchAtPoint(touch_point)

    # find the dx/dy of the touch on the placard
    @orig_touch_point = touch_point

    # if we want to change the size of the placard when picking it up, unlikely
#    UIView.animateWithDuration(GROW_ANIMATION_DURATION_SECONDS,
#      animations: -> {
#        placardView.transform = CGAffineTransformMakeScale(1.2, 1.2)
#      },
#      completion: -> (finished) {
#        UIView.animateWithDuration(MOVE_ANIMATION_DURATION_SECONDS,
#          animations: -> {
#            placardView.transform = CGAffineTransformMakeScale(1.1, 1.1)
#            placardView.center = touch_point
#          }
#        )
#      }
#    )
  end
  
  def animatePlacardViewToCenter
    welcomeLayer = placardView.layer

    # Create a keyframe animation to follow a path back to the center
    bounceAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    bounceAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = self.center.x
    midY = self.center.y

    # Start the path at the placard's current location
    CGPathMoveToPoint(thePath, nil, placardView.center.x, placardView.center.y)
    CGPathAddLineToPoint(thePath, nil, midX, midY)

    # if we want to bounce it back to the center, unlikely
#    stopBouncing = false
#
#    # Start the path at the placard's current location
#    CGPathMoveToPoint(thePath, nil, placardView.center.x, placardView.center.y)
#    CGPathAddLineToPoint(thePath, nil, midX, midY)
#
#    # Add to the bounce path in decreasing excursions from the center
#    while !stopBouncing
#      CGPathAddLineToPoint(thePath, nil, midX + originalOffsetX / offsetDivider,
#                                         midY + originalOffsetY / offsetDivider)
#      CGPathAddLineToPoint(thePath, nil, midX, midY)
#
#      offsetDivider += 4
#      animationDuration += 1 / offsetDivider
#      if ((originalOffsetX / offsetDivider).abs < 6) && ((originalOffsetY / offsetDivider).abs < 6)
#        stopBouncing = true
#      end
#    end

    bounceAnimation.path = thePath
    bounceAnimation.duration = animationDuration

    # Create an animation group to combine the keyframe and basic animations
    theGroup = CAAnimationGroup.animation

    # Set self as the delegate to allow for a callback to reenable user interaction
    theGroup.delegate = self
    theGroup.duration = animationDuration
    theGroup.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionLinear)
    theGroup.animations = [bounceAnimation]

    # Add the animation group to the layer
    welcomeLayer.addAnimation(theGroup, forKey: :animatePlacardViewToCenter)

    # Set the placard view's center and transformation to the original values in preparation for the
    # end of the animation
    placardView.center = self.center
    placardView.transform = CGAffineTransformIdentity
    @placard_view.rotate(2.degrees)
  end
end
