//
//  NotebookCollectionViewCell.swift
//  Nooty
//
//  Created by Jagdeep Singh on 08/12/21.
//

import UIKit

class NotebookCollectionViewCell: UICollectionViewCell {
  static let identifier = "NotebookCollectionViewCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 16)
    label.text = "Notebook name"
    return label
  }()
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(systemName: "books.vertical.circle.fill")
    imageView.tintColor = .systemCyan
    return imageView
  }()
   
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI(){
    contentView.backgroundColor = .init(named: "lightBlack")
    contentView.layer.cornerRadius = 20
    contentView.layer.shadowRadius = 4
    contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOpacity = 0.2
    setupTitleLabel()
    setupImageView()
  }
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.anchor(left: contentView.leadingAnchor, top: nil, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingLeft: 30, paddingTop: nil, paddingRight: 10, paddingBottom: 20)
    titleLabel.anchorHeightAndWidth(height: nil, heightConstant: 18, heightMultiplier: nil, width: nil, widthConstant: nil, widthMultiplier: nil)
  }
  
  private func setupImageView(){
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30).isActive = true
    imageView.centerInView(centerX: contentView.centerXAnchor, centerY: nil)
    imageView.anchorHeightAndWidth(height: nil, heightConstant: 90, heightMultiplier: nil, width: nil, widthConstant: 90, widthMultiplier: nil)
  }
}
