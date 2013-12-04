class NavController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    #self.title = "Navigation Example"
    imageView = UIImageView.alloc.initWithFrame(CGRectMake(0,0,320,64))
    imageView.contentMode = UIViewContentModeScaleAspectFit
    image = UIImage.imageNamed('navbar.png')
    imageView.setImage(image)
    navigationItem.titleView = imageView
  end
end