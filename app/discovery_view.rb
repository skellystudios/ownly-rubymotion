class DiscoveryView < UIView
  
  @orig_touch_point = nil
  @y_shift = 108
  @@placard_index = 0

  attr_reader :orig_touch_point, :placards, :placard_index, :drawer, :y_shift

  HOTSPOT_SCREEN_FRACTION = 3

  PLACARD_FILES = [
    "placards/C10.png",
    "placards/C11.png",
    "placards/C12.png",
    "placards/C13.png",
    "placards/C4.png",
    "placards/C5.png",
    "placards/C6.png",
    "placards/C7.png",
    "placards/C8.png",
    "placards/C9.png",
    "placards/M11.png",
    "placards/M15.png",
    "placards/M17.png",
    "placards/M22.png",
    "placards/M23.png",
    "placards/M27.png",
    "placards/M29.png",
    "placards/M30.png",
    "placards/M32.png",
    "placards/M33.png",
    "placards/M35.png",
    "placards/M36.png",
    "placards/M37.png",
    "placards/M38.png",
    "placards/M39.png",
    "placards/M43.png",
    "placards/M45.png",
    "placards/M47.png",
    "placards/M49.png",
    "placards/M51.png",
    "placards/M53.png",
    "placards/M54.png",
    "placards/M55.png",
    "placards/M56.png",
    "placards/M58.png",
    "placards/M72.png",
    "placards/M79.png",
    "placards/M80.png",
    "placards/M81.png",
    "placards/M90.png",
    "placards/M91.png",
    "placards/W10.png",
    "placards/W1.jpg",
    "placards/W1.png",
    "placards/W2.png",
    "placards/W3.png",
    "placards/W4.png",
    "placards/W5.png",
    "placards/W6.png",
    "placards/W7.png",
    "placards/W8.png"
  ].shuffle

  def initWithFrame(frame)
    if super

      if UIScreen.mainScreen.bounds.size.height < 560
        @y_shift = 60
      else
        @y_shift = 108
      end

      @drawer = UIImageView.alloc.initWithFrame(Rect(0, frame.height - 100, frame.width, 70))

      self.center.y = frame.width / 2
      self.center.x = frame.height / 2

#      @hotspot_view_red = HotspotRedView.alloc.initWithFrame(Rect(0, frame.y, frame.width, frame.height / HOTSPOT_SCREEN_FRACTION))
#      self << @hotspot_view_red
#
#      @hotspot_view_blue = HotspotBlueView.alloc.initWithFrame(Rect(0, -1*frame.y + frame.height - frame.height / HOTSPOT_SCREEN_FRACTION, frame.width, frame.height / HOTSPOT_SCREEN_FRACTION))
#      self << @hotspot_view_blue

      @placards = []
      for i in 0..2
        addPlacard
      end

      # add and draw the drawer
      @back_view = DrawerBackView.alloc.initWithFrame(Rect(14, frame.height - 100, frame.width - 28, 70))
      @front_view = DrawerFrontView.alloc.initWithFrame(Rect(8, frame.height - 96, frame.width - 16, 90))

      1.second.later do
        closeDrawer
      end

      #self.insertSubview(@label, belowSubview: @placards[@placards.length - 1])

#      @left_mask = DrawerMaskView.alloc.initWithFrame(Rect(0, frame.height - 96, 8, 70))
#      @right_mask = DrawerMaskView.alloc.initWithFrame(Rect(@front_view.frame.x + @front_view.frame.width, frame.height - 96, 8, 70))
#      @bottom_mask = DrawerMaskView.alloc.initWithFrame(Rect(0, @front_view.frame.y + @front_view.frame.height, frame.width, frame.height - @front_view.frame.y - @front_view.frame.height))

      self << @back_view
      self << @front_view

      #self.insertSubview(@front_view, belowSubview: @label)
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
  
  def addPlacard
    placard_view = PlacardView.alloc.initWithImage(PLACARD_FILES[@@placard_index])
    @@placard_index += 1

    if @@placard_index >= PLACARD_FILES.length
      @@placard_index = 0
    end

    placard_view.center = Point(self.center.x, self.center.y - @y_shift)
    placard_view.transform_equals(CGAffineTransformIdentity)
    @placards.push(placard_view)

    self.insertSubview(placard_view, atIndex: 0)
  end

  def touchesBegan(touches, withEvent: event)
    # We only support single touches, so anyObject retrieves just that touch from touches
    touch = touches.anyObject

    @accumulatedTouches = Array.new

    # Only move the placard view if the touch was in the placard view
    if touch.view == @placards[0]

      self.insertSubview(@back_view, belowSubview: @placards[0])
#      self.insertSubview(@left_mask, aboveSubview: @placards[0])
#      self.insertSubview(@right_mask, aboveSubview: @placards[0])
#      self.insertSubview(@bottom_mask, aboveSubview: @placards[0])

      # Animate the first touch
      animateFirstTouchAtPoint(touch.locationInView(@placards[0]))
    end
  end

  def touchesMoved(touches, withEvent: event)
    touch = touches.anyObject

    touches.each do |t|
      @accumulatedTouches << {"y" => t.locationInView(self).y, "time" => t.timestamp}
    end
    

    # If the touch was in the @placards[0], move the @placards[0] to its location
    if touch.view == @placards[0]
      location = touch.locationInView(self)

      midY = self.center.y - @y_shift
      distFromCenter = location.y - @orig_touch_point.y
      scaleFactor = ( 1.0 -  distFromCenter.abs / ( midY + 150 )) 
      p "distFromCenter " + distFromCenter.to_s
      p "scaleFactor " + scaleFactor.to_s

      if (distFromCenter > 20)
        openDrawer
      else
        closeDrawer
      end        

      @placards[0].transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor)
      @placards[0].center = Point(location.x - @orig_touch_point.x + (@placards[0].frame[1].width / 2) / scaleFactor, location.y - @orig_touch_point.y + (@placards[0].frame[1].height / 2 / scaleFactor))

    end
  end

  def closeDrawer()
    UIView.animate do
      @front_view.frame = Rect(14, frame.height - 80, frame.width - 28, 90)
    end
  end

  def openDrawer()
    UIView.animate do
      @front_view.frame = Rect(8, frame.height - 72, frame.width - 16, 90)
    end
  end
    
  def touchesEnded(touches, withEvent: event)
    touch = touches.anyObject

    if (@accumulatedTouches.length > 1)
      averageSpeed = (@accumulatedTouches[-1]["y"] - @accumulatedTouches[0]["y"]) / (@accumulatedTouches[-1]["time"] - @accumulatedTouches[0]["time"])
      finalSpeed = (@accumulatedTouches[-1]["y"] - @accumulatedTouches[-2]["y"]) / (@accumulatedTouches[-1]["time"] - @accumulatedTouches[-2]["time"])


      threshold_speed = 220

      if averageSpeed < -threshold_speed or finalSpeed < -threshold_speed
        animateDiscardPlacard
        closeDrawer
        return
      elsif averageSpeed > threshold_speed or finalSpeed > threshold_speed
        animateKeepPlacard
        0.5.second.later do
          closeDrawer
        end
        #@front_view.animate(@placards[0].center.y)
        return
      end
    end

    # If the touch was in the @placards[0], bounce it back to the center
    if touch.view == @placards[0]
      screen = UIScreen.mainScreen.bounds

      if @placards[0].center.y < screen.height / HOTSPOT_SCREEN_FRACTION - self.frame.y
        animateDiscardPlacard
      elsif @placards[0].center.y > screen.height - (screen.height / HOTSPOT_SCREEN_FRACTION)
        animateKeepPlacard
      else
        animatePlacardViewToCenter
      end
    end
  end
  
  def animationDidStop(theAnimation, finished: flag)
    id = theAnimation.valueForKey("id")

    if flag
      case id
      when "toCenter"
        @placards[0].transform_equals(CGAffineTransformIdentity)
      when "keep"
        @placards[0].removeFromSuperview
        @placards.delete_at(0)
        0.1.seconds.later do
          addPlacard
        end
      when "discard"
        @placards[0].removeFromSuperview
        @placards.delete_at(0)
        0.1.seconds.later do
          addPlacard
        end
      end

      self.userInteractionEnabled = true
    end
  end
  
  def animateFirstTouchAtPoint(touch_point)
    # find the dx/dy of the touch on the placard
    @orig_touch_point = touch_point
  end
  
  def animatePlacardViewToCenter
    self.userInteractionEnabled = false
    placardLayer = @placards[0].layer

    # Create a keyframe animation to follow a path back to the center
    toCenterAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    toCenterAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = self.center.x
    midY = self.center.y - @y_shift

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
    placardLayer.addAnimation(theGroup, forKey: :animatePlacardViewToCenter)

    # Set the placard view's center and transformation to the original values in preparation for the
    # end of the animation
    @placards[0].center = Point(self.center.x, self.center.y - @y_shift)
    @placards[0].transform_equals(CGAffineTransformIdentity)
  end

  def animateDiscardPlacard
    self.userInteractionEnabled = false
    placardLayer = @placards[0].layer

    # Create a keyframe animation to follow a path back to the center
    toCenterAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    toCenterAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = @placards[0].center.x
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
    placardLayer.addAnimation(theGroup, forKey: :animatePlacardViewTotop)

    @placards[0].center = Point(self.center.x, self.center.y - 500)
    # @placards[0].transform_equals(CGAffineTransformIdentity)
  end

  def animateKeepPlacard
    self.userInteractionEnabled = false
    placardLayer = @placards[0].layer

    # Create a keyframe animation to follow a path back to the center
    toCenterAnimation = CAKeyframeAnimation.animationWithKeyPath(:position)
    toCenterAnimation.removedOnCompletion = false

    animationDuration = 0.3

    # Create the path for the bounces
    thePath = CGPathCreateMutable()

    midX = @placards[0].center.x
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
    placardLayer.addAnimation(theGroup, forKey: :animatePlacardViewToBottom)

    @placards[0].center = Point(@placards[0].center.x, self.center.y + 500)
    # @placards[0].transform_equals(CGAffineTransformIdentity)
  end
end
