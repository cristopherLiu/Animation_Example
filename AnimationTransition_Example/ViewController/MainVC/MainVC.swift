//
//  Page1VC.swift
//  AnimationTransition_Example
//
//  Created by hjliu on 2020/9/28.
//

import UIKit

class MainVC: UIViewController {
  
  lazy var rightBarButton: UIBarButtonItem = {
    let action1 = UIAction(title: "設定", image: UIImage(systemName: "gear")) { (_) in
      self.pushPage()
    }
    let action2 = UIAction(title: "登出", image: UIImage(systemName: "trash")) { (_) in
      print("2")
    }
    let menu = UIMenu(title: "", options: .displayInline, children: [action1, action2])
    let btn = UIBarButtonItem(title: "選單", image: UIImage(systemName: "person.crop.circle"), menu: menu)
    btn.tintColor = UIColor.white
    return btn
  }()
  
  lazy var collectionViewLayout: UICollectionViewLayout = {
    // 1
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                          heightDimension: .absolute(300))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    // 2
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    // 3
    group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(8), bottom: nil)
    let section = NSCollectionLayoutSection(group: group)
    //    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }()
  
  lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    view.backgroundColor = UIColor.clear
    view.dataSource = self
    view.delegate = self
    view.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.cellIdentifier())
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let dataService = DataService()
  private var rowViewModels: [RowViewModel] = []
//  private var selectedIndex: IndexPath?
  private var selectedCellFrame: CGRect?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    fetchData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func setupView() {
    //    self.navigationController?.delegate = self
    self.view.backgroundColor = UIColor.sec1
    self.navigationItem.rightBarButtonItem = rightBarButton
    
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func fetchData() {
    dataService.fetchData { (datas) in
      self.buildViewModels(datas: datas)
      self.collectionView.reloadData()
    }
  }
  
  private func buildViewModels(datas: [PhotoObject]) {
    
    var rows = [RowViewModel]()
    for data in datas {
      
      let image = AsyncImage(url: data.imageURL, imageDownloadHelper: ImageDownloadHelper())
      let rowViewModel = ImageCellViewModel(image: image, cellPressed: {
        self.presentPage(image: image.image)
      })
      rows.append(rowViewModel)
    }
    self.rowViewModels = rows
  }
  
  @objc func pushPage() {
    let page = PushVC()
    self.navigationController?.pushViewController(page, animated: true)
  }
  
  @objc func presentPage(image: UIImage?) {
    let page = PresentVC(image: image)
    page.modalPresentationStyle = .fullScreen
    page.transitioningDelegate = self
    self.present(page, animated: true, completion: nil)
  }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.rowViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellIdentifier(), for: indexPath)
    
    let rowViewModel = rowViewModels[indexPath.row]
    if let cell = cell as? CellConfiguraable {
      cell.setup(viewModel: rowViewModel)
    }
    cell.layoutIfNeeded()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//    self.selectedIndex = indexPath // 點擊的index
    
    if let theAttributes = collectionView.layoutAttributesForItem(at: indexPath) {
      let cellFrameInSuperview = collectionView.convert(theAttributes.frame, to: collectionView.superview)
      self.selectedCellFrame = cellFrameInSuperview
    }
    
    let rowViewModel = rowViewModels[indexPath.row]
    if let rowViewModel = rowViewModel as? ViewModelPressible {
      rowViewModel.cellPressed?()
    }
  }
}

extension MainVC: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = CustomNavigationAnimator()
    animator.reverse = operation == .pop
    return animator
  }
}

extension MainVC: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if let selectedCellFrame = self.selectedCellFrame {
      return CustomPresentAnimator(originFrame: selectedCellFrame)
    }
    return nil
    
//    if let selectedIndex = selectedIndex, let theAttributes = collectionView.layoutAttributesForItem(at: selectedIndex) {
//      let cellFrameInSuperview = collectionView.convert(theAttributes.frame, to: collectionView.superview)
//      return CustomPresentAnimator(originFrame: cellFrameInSuperview)
//    }
//    return nil
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if let selectedCellFrame = self.selectedCellFrame {
      return CustomDismissAnimator(destinationFrame: selectedCellFrame)
    }
    return nil
    
//    if let selectedIndex = selectedIndex, let theAttributes = collectionView.layoutAttributesForItem(at: selectedIndex) {
//      let cellFrameInSuperview = collectionView.convert(theAttributes.frame, to: collectionView.superview)
//      return CustomDismissAnimator(destinationFrame: cellFrameInSuperview)
//    }
//    return nil
    //    return CustomDismissAnimator2()
  }
}
