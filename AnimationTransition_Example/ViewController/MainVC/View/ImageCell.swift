//
//  ImageCell.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import UIKit

class ImageCell: UICollectionViewCell, CellConfiguraable {
  
  private lazy var bgView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.backgroundColor = UIColor.clear
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // loaging
  lazy var loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .gray)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  private var viewModel: ImageCellViewModel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    
    contentView.addSubview(bgView)
    bgView.addSubview(imageView)
    bgView.addSubview(loadingIndicator)
    
    NSLayoutConstraint.activate([
      bgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      bgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
      bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      imageView.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 16),
      imageView.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -16),
      imageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
      imageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
      
      loadingIndicator.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
    ])
  }
  
  func setup(viewModel: RowViewModel){
    guard let viewModel = viewModel as? ImageCellViewModel else { return }
    self.viewModel = viewModel
    
    // 內容
    if let downloadImage = self.viewModel?.image.downloadImage {
      // 已有下載到內容
      self.setImage(downloadImage)
    } else {
      self.loadingIndicator.startAnimating()
      
      self.viewModel?.image.completeDownload = { [weak self] image in
        self?.loadingIndicator.stopAnimating()
        
        if let image = image {
          self?.setImage(image)
        }
      }
      self.viewModel?.image.startDownload()
    }
    setNeedsLayout()
  }
  
  private func setImage(_ image: UIImage) {
    self.imageView.image = image
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.imageView.image = nil
    viewModel?.image.completeDownload = nil
    viewModel?.cellPressed = nil
  }
}
