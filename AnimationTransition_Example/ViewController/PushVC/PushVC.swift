//
//  Page2VC.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class PushVC: UIViewController {
  
  lazy var backButton: UIBarButtonItem = {
    
    let action1 = UIAction(title: "複製", image: UIImage(systemName: "scissors")) { (_) in
      print("1")
    }
    let action2 = UIAction(title: "貼上", image: UIImage(systemName: "pencil")) { (_) in
      print("2")
    }
    let actionMenu = UIMenu(title: "", options: .displayInline, children: [action1, action2])
    let backAction = UIAction(title: "返回", image: UIImage(systemName: "arrowtriangle.left.fill"), attributes: .destructive, handler: { _ in
      self.navigationController?.popViewController(animated: true)
    })
    
    let button = UIBarButtonItem(title: "功能", image: UIImage(systemName: "line.horizontal.3"))
    button.menu = UIMenu(title: "選單", children: [actionMenu, backAction])
    button.tintColor = UIColor.white
    return button
  }()
  
  lazy var diceView: UIView = {
    let diceBgView = UIView()
    
//    diceView.frame = CGRect(x: 50, y: 0, width: screenFrame.width - 50, height: screenFrame.height)
//    let diceFrame = CGRect(x: (screenFrame.maxX - 50) / 2 - 50, y: screenFrame.maxY / 2 - 50, width: 100, height: 100)
    
    diceBgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    diceBgView.center = self.view.center
    let diceFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    //1
    let dice1 = UIImageView.init(image: UIImage(named: "dice1"))
    dice1.frame = diceFrame
    var transform1 = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 50)
    dice1.layer.transform = transform1
    
    //2
    let dice2 = UIImageView.init(image: UIImage(named: "dice2"))
    dice2.frame = diceFrame
    var transform2 = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
    transform2 = CATransform3DTranslate(transform2, 0, 0, 50)
    dice2.layer.transform = transform2
    
    //3
    let dice3 = UIImageView.init(image: UIImage(named: "dice3"))
    dice3.frame = diceFrame
    var transform3 = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 1, 0, 0)
    transform3 = CATransform3DTranslate(transform3, 0, 0, 50)
    dice3.layer.transform = transform3
    
    //4
    let dice4 = UIImageView.init(image: UIImage(named: "dice4"))
    dice4.frame = diceFrame
    var transform4 = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
    transform4 = CATransform3DTranslate(transform4, 0, 0, 50)
    dice4.layer.transform = transform4
    
    //5
    let dice5 = UIImageView.init(image: UIImage(named: "dice5"))
    dice5.frame = diceFrame
    var transform5 = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 0, 1, 0)
    transform5 = CATransform3DTranslate(transform5, 0, 0, 50)
    dice5.layer.transform = transform5
    
    //6
    let dice6 = UIImageView.init(image: UIImage(named: "dice6"))
    dice6.frame = diceFrame
    var transform6 = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -50)
    dice6.layer.transform = transform6
    
    diceBgView.addSubview(dice1)
    diceBgView.addSubview(dice2)
    diceBgView.addSubview(dice3)
    diceBgView.addSubview(dice4)
    diceBgView.addSubview(dice5)
    diceBgView.addSubview(dice6)
    
    return diceBgView
  }()
  
  let screenFrame = UIScreen.main.bounds
  var angle = CGPoint.zero
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    self.view.backgroundColor = UIColor.gy
    self.navigationItem.leftBarButtonItem = backButton
    
    self.view.addSubview(diceView)
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
    diceView.addGestureRecognizer(panGesture)
  }
  
  @objc func viewTransform(sender: UIPanGestureRecognizer) {
    
    let point = sender.translation(in: diceView)
    let angleX = angle.x + (point.x/30)
    let angleY = angle.y - (point.y/30)
    
    var transform = CATransform3DIdentity
    transform.m34 = -1 / 500
    transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
    transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
    diceView.layer.sublayerTransform = transform
    
    if sender.state == .ended {
      angle.x = angleX
      angle.y = angleY
    }
  }
}
