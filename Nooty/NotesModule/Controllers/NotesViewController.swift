//
//  ViewController.swift
//  Nooty
//
//  Created by Ajay on 26/11/21.
//

import UIKit
import SwiftUI
import CHTCollectionViewWaterfallLayout

class NotesViewController: UIViewController {
  
  private let notesCollectionView: UICollectionView = {
    let layout = CHTCollectionViewWaterfallLayout()
    layout.itemRenderDirection = .leftToRight
    layout.columnCount = 2
    layout.minimumInteritemSpacing = 18
    layout.minimumColumnSpacing = 18
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .systemBackground
    collectionView.register(
      NoteCollectionViewCell.self,
      forCellWithReuseIdentifier: NoteCollectionViewCell.identifier
    )
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Notes"
    navigationController?.navigationBar.prefersLargeTitles = true
    setupView()
  }
  
  private func setupView() {
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    notesCollectionView.dataSource = self
    notesCollectionView.delegate = self
    
    view.addSubview(notesCollectionView)
    notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    notesCollectionView.anchor(left: view.leadingAnchor, top: view.topAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingLeft: 16, paddingTop: 40, paddingRight: 16, paddingBottom: 0)
  }
}

extension NotesViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
  
  func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
    CGSize(width: view.frame.size.width/2, height: notes[indexPath.item].height)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    notes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: NoteCollectionViewCell.identifier,
      for: indexPath
    ) as? NoteCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.titleLabel.text = "Tasks"
    return cell
  }
}


/// SwiftUI Previews
#if DEBUG
struct NotesIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> UINavigationController {
    return UINavigationController(rootViewController: NotesViewController())
  }
  
  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    
  }
}

struct NotesControllerView: View {
  var body: some View {
    NotesIntegratedController().ignoresSafeArea(.all)
  }
}

struct ViewControllerPreviews: PreviewProvider {
  static var previews: some View {
    Group {
      NotesControllerView().colorScheme(.light)
      NotesControllerView().colorScheme(.dark)
    }
  }
}
#endif
