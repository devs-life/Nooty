//
//  NotebooksViewController.swift
//  Nooty
//
//  Created by Jagdeep Singh on 08/12/21.
//

import UIKit
import SwiftUI

class NotebooksViewController: UIViewController {
  
  private let notebooksCollectionView: UICollectionView = {
    let layout = createLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .systemBackground
    collectionView.register(
      NotebookCollectionViewCell.self,
      forCellWithReuseIdentifier: NotebookCollectionViewCell.identifier
    )
    return collectionView
  }()
  
  let floatingActionButton = FloatingActionButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    title = "Notebooks"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func setupView() {
    setupCollectionView()
    setUpFloatingActionButton()
  }
  
  private func setupCollectionView() {
    notebooksCollectionView.dataSource = self
    notebooksCollectionView.delegate = self
    
    view.addSubview(notebooksCollectionView)
    notebooksCollectionView.anchor(left: view.leadingAnchor, top: view.topAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingLeft: 10, paddingTop: 44, paddingRight: 10, paddingBottom: 0)
  }
  private func setUpFloatingActionButton(){
    view.addSubview(floatingActionButton)
    floatingActionButton.anchor(left: nil, top: nil, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingLeft: nil, paddingTop: nil, paddingRight: 20, paddingBottom: 20)
    floatingActionButton.anchorHeightAndWidth(height: nil, heightConstant: 60, heightMultiplier: nil, width: nil, widthConstant: 60, widthMultiplier: nil)
  }
}

extension NotebooksViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
    CGSize(width: view.frame.size.width/2, height: 180)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    notes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: NotebookCollectionViewCell.identifier,
      for: indexPath
    ) as? NotebookCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.titleLabel.text = "Somethings"
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    navigationController?.pushViewController(NotesViewController(), animated: true)
  }
}
extension NotebooksViewController {
  
  static func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(180))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    let spacing = CGFloat(20)
    group.interItemSpacing = .fixed(spacing)
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    
    // Another way to add spacing. This is done for the section.
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
}


/// SwiftUI Previews
#if DEBUG
struct NotesbookIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> UINavigationController {
    return UINavigationController(rootViewController: NotebooksViewController())
  }
  
  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    
  }
}

struct NotesBookControllerView: View {
  var body: some View {
    NotesbookIntegratedController().ignoresSafeArea(.all)
  }
}

struct NBViewControllerPreviews: PreviewProvider {
  static var previews: some View {
    NotesBookControllerView().colorScheme(.dark)
  }
}
#endif
