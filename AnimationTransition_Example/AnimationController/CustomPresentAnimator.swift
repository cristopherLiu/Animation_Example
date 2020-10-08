//
//  MyAnimatedTransitioning.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class CustomPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  var duration: TimeInterval = 2
  private let originFrame: CGRect
  
  init(originFrame: CGRect) {
    self.originFrame = originFrame
  }
  
  // 轉場動畫的時間
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  // 具體的動畫實現
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromVC = transitionContext.viewController(forKey: .from),
      let toVC = transitionContext.viewController(forKey: .to),
      let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
    else {
      transitionContext.completeTransition(false)
      return
    }
    
    let containerView = transitionContext.containerView
    let finalFrame = transitionContext.finalFrame(for: toVC)
    
    snapshot.frame = originFrame
    snapshot.layer.cornerRadius = 16
    snapshot.layer.masksToBounds = true
    
    containerView.addSubview(toVC.view)
    containerView.addSubview(snapshot)
    toVC.view.isHidden = true
    snapshot.isHidden = true
    
    AnimationHelper.perspectiveTransform(sub: containerView)
    
//    snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
    
//    UIView.animateKeyframes(
//      withDuration: duration,
//      delay: 0,
//      options: .calculationModeCubic,
//      animations: {
//
//        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
//          fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
//        }
//
//        UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
//          snapshot.layer.transform = AnimationHelper.yRotation(.pi * 2)
//        }
//
//        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
//          snapshot.frame = finalFrame
//          snapshot.layer.cornerRadius = 0
//        }
//      },
//      completion: { _ in
//        toVC.view.isHidden = false
//        snapshot.removeFromSuperview()
//        fromVC.view.layer.transform = CATransform3DIdentity
//        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//      })
    
    let animator1 = UIViewPropertyAnimator(duration: duration * 1/3, curve: .linear, animations: {
      fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
    })
    let animator2 = UIViewPropertyAnimator(duration: duration * 1/3, curve: .linear, animations: {
      snapshot.layer.transform = AnimationHelper.yRotation(0)
    })
    let animator3 = UIViewPropertyAnimator(duration: duration * 1/3, curve: .linear, animations: {
      snapshot.frame = finalFrame
      snapshot.layer.cornerRadius = 0
    })

    animator1.addCompletion { (_) in
      snapshot.isHidden = false
      snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
      animator2.startAnimation()
    }
    animator2.addCompletion { (_) in
      animator3.startAnimation()
    }
    animator3.addCompletion { (_) in
      toVC.view.isHidden = false
      snapshot.removeFromSuperview()
      fromVC.view.layer.transform = CATransform3DIdentity
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    animator1.startAnimation()
  }
  
  // 動畫完成後的收尾動作
  func animationEnded(_ transitionCompleted: Bool) {
    
  }
}

//enum PresentationType {
//  case present
//  case dismiss
//
//  var isPresenting: Bool {
//    return self == .present
//  }
//}
