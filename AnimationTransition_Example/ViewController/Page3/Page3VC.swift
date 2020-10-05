//
//  Page3VC.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class Page3VC: UIViewController {
  
  lazy var button: UIButton = {
    let btn = UIButton()
    btn.setTitle("返回", for: .normal)
    btn.setTitleColor(UIColor.black, for: .normal)
    btn.layer.cornerRadius = 16
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
    return btn
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.red
    
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      
      button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
      button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
      button.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
  
  @objc func dismissPage() {
    self.dismiss(animated: true, completion: nil)
  }
}
