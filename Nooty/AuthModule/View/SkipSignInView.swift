//
//  SkipSignInView.swift
//  Nooty
//
//  Created by Jagdeep Singh on 07/12/21.
//

import UIKit

protocol SkipSignInViewDelegate {
  
  func navigateToNotebooks()
}

class SkipSignInView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  var delegate: SkipSignInViewDelegate?
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI(){
    
    let skipLabel = UILabel()
    addSubview(skipLabel)
    
    skipLabel.anchor(left: leadingAnchor, top: topAnchor, right: nil, bottom: nil, paddingLeft: 20, paddingTop: 10, paddingRight: nil, paddingBottom: nil)
    skipLabel.anchorHeightAndWidth(height: nil, heightConstant: 18, heightMultiplier: nil, width: nil, widthConstant: 165, widthMultiplier: nil)
    skipLabel.text = "Wanna do signin later"
    
    let skipBtn = UIButton(type: .system)
    addSubview(skipBtn)
    
    skipBtn.anchorHeightAndWidth(height: nil, heightConstant: 16, heightMultiplier: nil, width: nil, widthConstant: nil, widthMultiplier: nil)
    skipBtn.anchor(left: skipLabel.trailingAnchor, top: topAnchor, right: trailingAnchor, bottom: nil, paddingLeft: -15, paddingTop: 12, paddingRight: 0, paddingBottom: nil)
    
    skipBtn.addTarget(self, action: #selector(skipButtonChicked), for: .touchUpInside)
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 14),
      .foregroundColor: UIColor.label,
      .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    let attributeString = NSMutableAttributedString(
      string: "Skip it",
      attributes: attributes)
    skipBtn.setAttributedTitle(attributeString, for: .normal)
    skipBtn.setTitleColor(.label, for: .normal)
  }
  
  @objc func skipButtonChicked(){
    
    guard let delegate = self.delegate else {
      return
    }

    delegate.navigateToNotebooks()
  }
  
}
