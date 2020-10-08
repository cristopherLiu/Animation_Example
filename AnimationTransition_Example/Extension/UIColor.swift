//
//  UIColor.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import Foundation
import UIKit

extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
  
  func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
    
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    
    let context = UIGraphicsGetCurrentContext()
    
    self.setFill()
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
}

extension UIColor {
  
  static let pri = UIColor(rgb: 0x00A794)
  static let pri_5 = UIColor(rgb: 0x00A794).withAlphaComponent(0.5)
  static let pri_3 = UIColor(rgb: 0x00A794).withAlphaComponent(0.3)
  
  static let sec1 = UIColor(rgb: 0x5DCB9A)
  static let sec2 = UIColor(rgb: 0xFFBD86)
  
  static let dan = UIColor(rgb: 0xFF6565)
  static let dan_5 = UIColor(rgb: 0xFF6565).withAlphaComponent(0.5)
  
  static let w = UIColor(rgb: 0xffffff)
  static let w_5 = UIColor(rgb: 0xffffff).withAlphaComponent(0.5)
  static let w_3 = UIColor(rgb: 0xffffff).withAlphaComponent(0.3)
  
  static let gy = UIColor(rgb: 0xF5F6FA)
  static let gy_5 = UIColor(rgb: 0xF5F6FA).withAlphaComponent(0.5)
  
  static let bk = UIColor(rgb: 0x4D6A8D)
  static let bk_8 = UIColor(rgb: 0x4D6A8D).withAlphaComponent(0.8)
  static let bk_5 = UIColor(rgb: 0x4D6A8D).withAlphaComponent(0.5)
  static let bk_3 = UIColor(rgb: 0x4D6A8D).withAlphaComponent(0.3)
  
  static let bg_8 = UIColor(rgb: 0x20344D).withAlphaComponent(0.8)
}
