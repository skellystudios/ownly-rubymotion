class DrawerPlacard < UIView
  def initWithFrame(frame, withImage: image, andLink: link)
    super

    @link = link

    image_dumb = UIImageView.alloc.initWithFrame(frame)
    image_dumb.setImage(UIImage.imageNamed(image))

    image_dumb.layer.masksToBounds = true
    image_dumb.layer.borderColor = :black.uicolor.CGColor
    image_dumb.layer.borderWidth = 0.5

    self << image_dumb

    own_button = DrawerOwnView.alloc.initWithFrame(Rect(frame.x + 30, frame.y + frame.height / 2 + 20, frame.width / 3, 20))
    own_button.center = Point(self.center.x, own_button.center.y)
    self << own_button
  end

  def drawRect(rect)
  end
end
