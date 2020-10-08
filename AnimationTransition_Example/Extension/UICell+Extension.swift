//
//  UICell+Extension.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import Foundation
import UIKit

public extension UITableViewCell {
  /// Generated cell identifier derived from class name
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
  
  var tableView: UITableView? {
    return parentView(of: UITableView.self)
  }
}

public extension UICollectionViewCell{
  /// Generated cell identifier derived from class name
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}

public extension UITableViewHeaderFooterView{
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}
