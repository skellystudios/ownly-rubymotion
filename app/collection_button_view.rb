class CollectionButtonView < UIView
  def init

  end

  def drawRect(rect)
    maskPath = UIBezierPath.bezierPathWithRoundedRect(_backgroundImageView.boundsm, byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight), cornerRadii:CGSizeMake(3.0, 3.0))

    maskLayer = CAShapeLayer.alloc.init
    maskLayer.frame = self.bounds
    maskLayer.path = maskPath.CGPath
    _backgroundImageView.layer.mask = maskLayer
  end
end
