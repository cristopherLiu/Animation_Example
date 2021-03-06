//
//  AnimationHelper.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

struct AnimationHelper {
  static func yRotation(_ angle: Double) -> CATransform3D {
    return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
  }
  
  static func perspectiveTransform(for containerView: UIView) {
    var transform = CATransform3DIdentity
    transform.m34 = -0.002
//    containerView.layer.sublayerTransform = transform
    containerView.layer.transform = transform
  }
  
  static func perspectiveTransform(sub containerView: UIView) {
    var transform = CATransform3DIdentity
    transform.m34 = -0.002
    containerView.layer.sublayerTransform = transform
  }
}
