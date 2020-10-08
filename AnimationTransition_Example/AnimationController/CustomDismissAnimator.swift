//
//  CustomDismissAnimator.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class CustomDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  var duration: TimeInterval = 2
  private let destinationFrame: CGRect
  
  init(destinationFrame: CGRect) {
    self.destinationFrame = destinationFrame
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
    else {
      transitionContext.completeTransition(false)
      return
    }
    
    snapshot.layer.cornerRadius = 16
    snapshot.layer.masksToBounds = true
    
    let containerView = transitionContext.containerView
    containerView.insertSubview(toVC.view, at: 0)
    containerView.addSubview(snapshot)
    fromVC.view.isHidden = true
    
    AnimationHelper.perspectiveTransform(sub: containerView)
    
//    AnimationHelper.perspectiveTransform(for: containerView)
//    AnimationHelper.perspectiveTransform(for: toVC.view)
//    AnimationHelper.perspectiveTransform(for: snapshot)
    
    toVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
    
//    UIView.animateKeyframes(
//      withDuration: duration,
//      delay: 0,
//      options: .calculationModeCubic,
//      animations: {
//
//        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
//          snapshot.frame = self.destinationFrame
//        }
//
//        UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
//          snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
//        }
//
//        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
//          toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
//        }
//      },
//      completion: { _ in
//        fromVC.view.isHidden = false
//        snapshot.removeFromSuperview()
//        if transitionContext.transitionWasCancelled {
//          toVC.view.removeFromSuperview()
//        }
//        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//      })
    
    let animator1 = UIViewPropertyAnimator(duration: duration * 1/3, curve: .linear, animations: {
      snapshot.frame = self.destinationFrame
    })
    let animator2 = UIViewPropertyAnimator(duration: duration * 1/3, curve: .linear, animations: {
      snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
    })
    let animator3 = UIViewPropertyAnimator(duration: duration * 1/3, curve: .linear, animations: {
      toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
    })

    animator1.addCompletion { (_) in
      animator2.startAnimation()
    }
    animator2.addCompletion { (_) in
      snapshot.isHidden = true
      animator3.startAnimation()
    }
    animator3.addCompletion { (_) in
      fromVC.view.isHidden = false
      snapshot.removeFromSuperview()
      if transitionContext.transitionWasCancelled {
        toVC.view.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    animator1.startAnimation()
  }
}
