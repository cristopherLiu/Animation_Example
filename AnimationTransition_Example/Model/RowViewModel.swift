//
//  RowViewModel.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import Foundation

protocol RowViewModel {
}

protocol ViewModelPressible {
  var cellPressed: (()->Void)? { get set }
}

protocol CellConfiguraable {
  func setup(viewModel: RowViewModel)
}
