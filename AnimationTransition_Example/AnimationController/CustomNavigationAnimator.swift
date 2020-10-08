//
//  CustomNavigationAnimator.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class CustomNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  var reverse: Bool = false
  
  // 轉場動畫的時間
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 2
  }
  
  // 具體的動畫實現
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let containerView = transitionContext.containerView
    
    guard
      let fromVC = transitionContext.viewController(forKey: .from),
      let toVC = transitionContext.viewController(forKey: .to),
      let fromView = transitionContext.view(forKey: .from),
      let toView = transitionContext.view(forKey: .to)
    else {
      transitionContext.completeTransition(false)
      return
    }
    
    let direction: CGFloat = reverse ? -1 : 1
    let const: CGFloat = -0.005
    
    toView.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
    fromView.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)
    
    var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * .pi / 2, 0.0, 1.0, 0.0)
    var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * .pi / 2, 0.0, 1.0, 0.0)
    viewFromTransform.m34 = const
    viewToTransform.m34 = const
    
    containerView.transform = CGAffineTransform(translationX: direction * containerView.frame.size.width / 2.0, y: 0)
    toView.layer.transform = viewToTransform
    containerView.addSubview(toView)
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
      
      containerView.transform = CGAffineTransform(translationX: -direction * containerView.frame.size.width / 2.0, y: 0)
      fromView.layer.transform = viewFromTransform
      toView.layer.transform = CATransform3DIdentity
      
    }, completion: { finished in
      
      containerView.transform = CGAffineTransform.identity
      fromView.layer.transform = CATransform3DIdentity
      toView.layer.transform = CATransform3DIdentity
      fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      
      if (transitionContext.transitionWasCancelled) {
        toView.removeFromSuperview()
      } else {
        fromView.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
  
  // 動畫完成後的收尾動作
  func animationEnded(_ transitionCompleted: Bool) {
    
  }
}
