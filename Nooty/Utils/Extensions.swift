//
//  Extensions.swift
//  Nooty
//
//  Created by Ajay on 27/11/21.
//

import UIKit

extension UIView {
  func anchor(left: NSLayoutXAxisAnchor?, top: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddingLeft: CGFloat, paddingTop: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, height: NSLayoutDimension?, heightConstant: CGFloat?, heightMultiplier: CGFloat?, width: NSLayoutDimension?, widthConstant: CGFloat?, widthMultiplier: CGFloat?) {
    
    if let top = top {
      self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
      self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
      self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if let height = height {
      self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier ?? 1).isActive = true
    }
    
    if let width = width {
      self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier ?? 1).isActive = true
    }
    
    if let heightConstant = heightConstant {
      self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }
    
    if let widthConstant = widthConstant {
      self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
    }
  }
}
