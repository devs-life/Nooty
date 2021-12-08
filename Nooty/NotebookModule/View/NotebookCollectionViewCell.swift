//
//  NotebookCollectionViewCell.swift
//  Nooty
//
//  Created by Jagdeep Singh on 08/12/21.
//

import UIKit

class NotebookCollectionViewCell: UICollectionViewCell {
  
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
    titleLabel.anchor(left: contentView.leadingAnchor, top: nil, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingLeft: 20, paddingTop: nil, paddingRight: 20, paddingBottom: 20)
    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    titleLabel.anchorHeightAndWidth(height: nil, heightConstant: 18, heightMultiplier: nil, width: nil, widthConstant: nil, widthMultiplier: nil)
  }
  
  private func setupImageView(){
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.centerInView(centerX: contentView.centerXAnchor, centerY: contentView.centerYAnchor)
    imageView.anchorHeightAndWidth(height: nil, heightConstant: 70, heightMultiplier: nil, width: nil, widthConstant: 70, widthMultiplier: nil)
  }
}
