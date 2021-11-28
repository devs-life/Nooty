//
//  CollectionViewCell.swift
//  Nooty
//
//  Created by Ajay on 27/11/21.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
  static let identifier = "NoteCollectionViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .gray
    contentView.layer.cornerRadius = 20
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}
