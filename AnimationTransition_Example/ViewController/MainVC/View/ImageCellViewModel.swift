//
//  ImageCellViewModel.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import UIKit

class ImageCellViewModel: RowViewModel, ViewModelPressible {
  
  let image: AsyncImage
  var cellPressed: (() -> Void)?
  
  init(image: AsyncImage, cellPressed: (() -> Void)? = nil) {
    self.image = image
    self.cellPressed = cellPressed
  }
}
