class NavView < UIView
  def viewDidLoad
    frame = Rect(0, 0, 320, 64)
    view.backgroundColor = :white.uicolor

#    imageView = UIImageView.alloc.initWithFrame(frame)
#    imageView.contentMode = UIViewContentModeScaleAspectFit
#    image = UIImage.imageNamed('navbar.png')
#    imageView.setImage(image)

    label = UILabel.alloc.initWithFrame(frame)
    label.text = "OWNLY"
    label.textColor = "#5783c2".uicolor
    label.textAlignment = NSTextAlignmentCenter
    label.font = :cocon.uifont(32)

    self.view << imageView
    self.view << label
  end

  def drawRect(rect)
    [236, 236, 236].uicolor.setFill
    UIRectFill(rect)
  end
end
