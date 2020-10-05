//
//  CustomInteractionController.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/29.
//

import UIKit

class CustomInteractionController: UIPercentDrivenInteractiveTransition {
  
  var navigationController: UINavigationController!
  var shouldCompleteTransition = false
  var transitionInProgress = false
  
  var completionSeed: CGFloat {
    return 1 - percentComplete
  }
  
  func attachToViewController(viewController: UIViewController) {
    navigationController = viewController.navigationController
    setupGestureRecognizer(view: viewController.view)
  }
  
  private func setupGestureRecognizer(view: UIView) {
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gestureRecognizer:)))
    view.addGestureRecognizer(gesture)
  }
  
  @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
    
    guard let gView = gestureRecognizer.view, let superview = gView.superview else {
      return
    }
    let viewTranslation = gestureRecognizer.translation(in: superview)
    switch gestureRecognizer.state {
    
    // 開始
    case .began:
      transitionInProgress = true
      navigationController.popViewController(animated: true)
      
    // 移動
    case .changed:
      let const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 200.0), 0.0), 1.0))
      shouldCompleteTransition = const > 0.5
      update(const)
      
    // 結束 取消
    case .cancelled, .ended:
      transitionInProgress = false
      if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
        cancel()
      } else {
        finish()
      }
    default: break
    }
  }
}
