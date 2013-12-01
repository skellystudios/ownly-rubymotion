class PlacardView < UIView

  def init
    # Retrieve the image for the view and determine its size
    image = UIImage.imageNamed('rihanna.png')
    frame = CGRectMake(0, 0, image.size.width + 6, image.size.height + 6)

    # Set self's frame to encompass the image
    if initWithFrame(frame)
      self.opaque = false
      @placard_image = image
    end

    self
  end

  def drawRect(rect)
    @placard_image.drawAtPoint(CGPointMake(3, 3))

    self.layer.borderWidth = 3 
    self.layer.borderColor = UIColor.clearColor
    self.layer.shouldRasterize = true 

    self.layer.shadowOffset = CGSizeMake(0, -1)
    self.layer.shadowOpacity = 1
    self.layer.shadowColor = UIColor.blackColor.CGColor
  end
  
end