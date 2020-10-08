//
//  Page3VC.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class PresentVC: UIViewController {
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.backgroundColor = UIColor.clear
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var button: UIButton = {
    let btn = UIButton()
    let image = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
    btn.setImage(image, for: .normal)
    btn.tintColor = .w
    btn.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    btn.layer.cornerRadius = 16
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
    return btn
  }()
  
  var image: UIImage?
  
  init(image: UIImage?) {
    super.init(nibName: nil, bundle: nil)
    self.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.dan
    
    view.addSubview(imageView)
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      
      imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
      button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      button.widthAnchor.constraint(equalToConstant: 48),
      button.heightAnchor.constraint(equalToConstant: 48),
    ])
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.imageView.image = image
  }
  
  @objc func dismissPage() {
    self.dismiss(animated: true, completion: nil)
  }
}
