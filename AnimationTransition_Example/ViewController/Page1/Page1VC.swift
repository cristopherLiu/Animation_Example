//
//  Page1VC.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class Page1VC: UIViewController {
  
  lazy var button1: UIButton = {
    let btn = UIButton()
    btn.setTitle("Push下一頁", for: .normal)
    btn.setTitleColor(UIColor.white, for: .normal)
    btn.backgroundColor = UIColor.red
    btn.layer.cornerRadius = 16
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(pushPage), for: .touchUpInside)
    return btn
  }()
  
  lazy var button2: UIButton = {
    let btn = UIButton()
    btn.setTitle("Present下一頁", for: .normal)
    btn.setTitleColor(UIColor.white, for: .normal)
    btn.backgroundColor = UIColor.red
    btn.layer.cornerRadius = 16
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(presentPage), for: .touchUpInside)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()    
//    self.navigationController?.delegate = self
    self.view.backgroundColor = UIColor.white
    view.addSubview(button1)
    view.addSubview(button2)
    
    NSLayoutConstraint.activate([
      
      button1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
      button1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
      button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      button1.heightAnchor.constraint(equalToConstant: 200),
      
      button2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
      button2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
      button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 16),
      button2.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  @objc func pushPage() {
    let page = Page2VC()
    self.navigationController?.pushViewController(page, animated: true)
  }
  
  @objc func presentPage() {
    let page = Page3VC()
    page.modalPresentationStyle = .fullScreen
    page.transitioningDelegate = self
    self.present(page, animated: true, completion: nil)
  }
}

extension Page1VC: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = CustomNavigationAnimator()
    animator.reverse = operation == .pop
    return animator
  }
}

extension Page1VC: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return CustomPresentAnimator(originFrame: self.button2.frame)
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return CustomDismissAnimator(destinationFrame: self.button2.frame)
//    return CustomDismissAnimator2()
  }
}
