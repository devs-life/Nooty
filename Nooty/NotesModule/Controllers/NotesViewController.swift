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
    layout.minimumInteritemSpacing = 15
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(
      NoteCollectionViewCell.self,
      forCellWithReuseIdentifier: NoteCollectionViewCell.identifier
    )
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    notesCollectionView.dataSource = self
    notesCollectionView.delegate = self
    
    view.addSubview(notesCollectionView)
    notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    notesCollectionView.anchor(left: view.leftAnchor, top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingLeft: 10, paddingTop: 40, paddingRight: 20, paddingBottom: 0, height: nil, heightConstant: nil, heightMultiplier: nil, width: nil, widthConstant: nil, widthMultiplier: nil)
  }
}

extension NotesViewController: UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
  
  func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
    CGSize(width: view.frame.size.width/2, height: CGFloat.random(in: 200...280))
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    20
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
  
  func makeUIViewController(context: Context) -> NotesViewController {
    return NotesViewController()
  }
  
  func updateUIViewController(_ uiViewController: NotesViewController, context: Context) {
    
  }
}

struct NotesControllerView: View {
    var body: some View {
      NotesIntegratedController().ignoresSafeArea(.all)
    }
}

struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
      NotesControllerView()
    }
}
#endif
