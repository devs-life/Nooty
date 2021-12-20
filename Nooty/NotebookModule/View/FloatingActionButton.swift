//
//  FloatingActionButton.swift
//  Nooty
//
//  Created by Jagdeep Singh on 19/12/21.
//

import UIKit

class FloatingActionButton: UIButton {
  
  let plusImage = UIImageView(image: UIImage(systemName: "plus"))

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  init() {
    super.init(frame: .zero)
    configureUI()
  }
  private func configureUI(){
    backgroundColor = .systemPurple
    layer.cornerRadius = 36
    layer.shadowRadius = 4
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    setupImageView()
  }
  private func setupImageView(){
    addSubview(plusImage)
    plusImage.tintColor = .white
    plusImage.anchorHeightAndWidth(height: nil, heightConstant: 42, heightMultiplier: nil, width: nil, widthConstant: 42, widthMultiplier: nil)
    plusImage.centerInView(centerX: centerXAnchor, centerY: centerYAnchor)
    
  }
}
