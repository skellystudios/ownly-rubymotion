class DrawerPlacard < UIView
  def initWithFrame(frame, withImage: image, andLink: link)
    initWithFrame(frame)

    self.setBackgroundColor(:black.uicolor)

    @link = link

    image_dumb = UIImageView.alloc.initWithFrame(bounds)
    image_dumb.setImage(UIImage.imageNamed(image))

    image_dumb.layer.masksToBounds = true
    image_dumb.layer.borderColor = :black.uicolor.CGColor
    image_dumb.layer.borderWidth = 0.5

    self << image_dumb

    @own_button = DrawerOwnView.alloc.initWithFrame(Rect(image_dumb.x + 30, image_dumb.y + image_dumb.height / 2 + 20, image_dumb.width / 3, 20))
    @own_button.center = Point(image_dumb.center.x, @own_button.center.y)
    self << @own_button
  end

  def ownButton
    @own_button
  end

  def link
    @link
  end

  def drawRect(rect)
  end
end
