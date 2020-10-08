//
//  AsyncImage.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/10/6.
//

import Foundation
import UIKit

/// Promise-pattern wrapped image object, with in-memor eternal cache support
class AsyncImage {
  /// The url for the image resource
  let url: URL
  
  /// The downloeded image, it could be a placeholder image if the image is downloading or the download is failed
  var image: UIImage? {
    return self.imageStore ?? placeholder
  }
  
  var downloadImage: UIImage? {
    return self.imageStore
  }
  
  /// Image download complete closure
  var completeDownload: ((UIImage?) -> Void)?
  
  private var imageStore: UIImage?
  private var placeholder: UIImage?
  
  private let imageDownloadHelper: ImageDownloadHelperProtocol
  
  private var isDownloading: Bool = false
  
  init(url: String,
       placeholderImage: UIImage? = nil,
       imageDownloadHelper: ImageDownloadHelperProtocol = ImageDownloadHelper()) {
    self.url = URL(string: url)!
    self.placeholder = placeholderImage
    self.imageDownloadHelper = imageDownloadHelper
  }
  
  /// Start download the image with provided url
  func startDownload() {
    if imageStore != nil {
      completeDownload?(image)
    } else {
      if isDownloading { return }
      isDownloading = true
      imageDownloadHelper.download(url: url, completion: { [weak self] (image, response, error) in
        self?.imageStore = image
        self?.isDownloading = false
        DispatchQueue.main.async {
          self?.completeDownload?(image)
        }
      })
    }
  }
}
