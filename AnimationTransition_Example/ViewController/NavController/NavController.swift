//
//  MyNavController.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class NavController: UINavigationController {
  
  let customInteractionController = CustomInteractionController()
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
}

extension NavController: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if operation == .push {
      customInteractionController.attachToViewController(viewController: toVC)
    }
    
    let animator = CustomNavigationAnimator()
    animator.reverse = operation == .pop
    return animator
  }
  
  func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
      return customInteractionController.transitionInProgress ? customInteractionController : nil
  }
}
