//
//  CustomDismissAnimator2.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/29.
//

import Foundation
import UIKit

class CustomDismissAnimator2: NSObject, UIViewControllerAnimatedTransitioning {
  
  var duration: TimeInterval = 2
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
    else {
      return
    }
    
    let containerView = transitionContext.containerView
    let finalFrame = transitionContext.finalFrame(for: toVC)
    
    toVC.view.frame = finalFrame
    toVC.view.alpha = 0.5
    containerView.addSubview(toVC.view)
    containerView.sendSubviewToBack(toVC.view)
    
    snapshot.frame = fromVC.view.frame
    containerView.addSubview(snapshot)
    
    fromVC.view.removeFromSuperview()
    
    let animator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
      snapshot.frame = fromVC.view.frame.insetBy(dx: fromVC.view.frame.size.width / 2, dy: fromVC.view.frame.size.height / 2)
      toVC.view.alpha = 1.0
    })
    animator.addCompletion { (_) in
      snapshot.removeFromSuperview()
      transitionContext.completeTransition(true)
    }
    animator.startAnimation()
  }
}
