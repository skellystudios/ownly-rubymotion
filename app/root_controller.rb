class RootViewController < UIViewController
  def viewDidLoad

    xcode_image = UIImage.imageNamed("filters.png")

    @xcode_image_view1 = UIImageView.alloc.initWithImage(xcode_image)

    @xcode_image_view1.setFrame(CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 64))

    view.addSubview(@xcode_image_view1)

    @filterNames = ['dresses', 'pants', 'tanks', 'skirts', 'jackets', 'sneakers', 'shoes', 'bags', 'glasses', 'hats', 'headphones', 'jewelry']
    @buttons = []

    
    @filterNames.each_with_index{|filter,index|
      filterButton = UIView.alloc.init()
      filterButton.setFrame(CGRectMake(index.modulo(3) * 100 + 10, (index/3).floor * 116 + 16, 90, 90))
      # filterButton.backgroundColor = UIColor.colorWithRed(0, green:0, blue:0.5, alpha:0.1)

      tap_gesture_recognizer = UITapGestureRecognizer.alloc.initWithTarget( self, action:'tabGestureRecognizer:')

      filterButton.addGestureRecognizer( tap_gesture_recognizer)

      view.addSubview(filterButton)

      @buttons.push(filterButton)
    }
    
    view_controller = DiscoveryController.new
    self.parentViewController.pushViewController(view_controller, animated: true)

  end

  def tabGestureRecognizer(tap_gesture_recognizer)
    index = @buttons.index(tap_gesture_recognizer.view)
    p @filterNames[index]

    view_controller = DiscoveryController.new

    self.parentViewController.pushViewController(view_controller, animated: true)
  end


end
