//
//  NoteDetailViewController.swift
//  Nooty
//
//  Created by Ajay on 08/12/21.
//

import UIKit
import SwiftUI

class NoteDetailViewController: UIViewController {
  
  let textView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .systemFont(ofSize: 18)
    textView.text = "Your Note here..."
    textView.textColor = UIColor.lightGray
    textView.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    textView.isScrollEnabled = true
    return textView
  }()
  
  let titleField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.font = .boldSystemFont(ofSize: 26)
    tf.placeholder = "Title"
    return tf
  }()
  
  let seperatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .purple
    view.layer.cornerRadius = 2
    return view
  }()
  
  var textViewBottom : NSLayoutConstraint?
  
  lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
  
  lazy var containerView: UIView = {
    let view = UIView()
    view.frame.size = contentViewSize
    view.backgroundColor = .systemBackground
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.tintColor = UIColor.systemPurple
    setupMoreButton()
    setupSeperatorView()
    setuptTitleField()
    setupTextView()
    subscribeToKeyboardNotifications()
  }
  
  private func setupMoreButton() {
    let imageIcon = UIImage(systemName: "ellipsis.circle")
    let b = UIBarButtonItem.init(
      image: imageIcon,
      style: .done,
      target: self,
      action: #selector(moreAction)
    )
    
    self.navigationItem.rightBarButtonItem = b
  }
  
  private func setupSeperatorView() {
    view.addSubview(containerView)
    containerView.addSubview(seperatorView)
    
    seperatorView.anchor(left: containerView.leadingAnchor, top: containerView.safeAreaLayoutGuide.topAnchor, right: nil, bottom: nil, paddingLeft: 10, paddingTop: 10, paddingRight: 0, paddingBottom: 0)
    seperatorView.anchorHeightAndWidth(height: nil, heightConstant: 50, heightMultiplier: nil, width: nil, widthConstant: 4, widthMultiplier: nil)
  }
  
  private func setuptTitleField() {
    containerView.addSubview(titleField)
    titleField.centerInView(centerX: nil, centerY: seperatorView.centerYAnchor)
    titleField.anchor(
      left: seperatorView.trailingAnchor,
      top: nil,
      right: containerView.trailingAnchor,
      bottom: nil,
      paddingLeft: 10,
      paddingTop: 0,
      paddingRight: 8,
      paddingBottom: 0
    )
  }
  
  private func setupTextView() {
    containerView.addSubview(textView)
    
    textView.anchor(
      left: containerView.leadingAnchor,
      top: seperatorView.bottomAnchor,
      right: containerView.trailingAnchor,
      bottom: nil,
      paddingLeft: 15,
      paddingTop: 10,
      paddingRight: 8,
      paddingBottom: nil
    )
    
    textViewBottom = textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
    textViewBottom?.isActive = true
    
    textView.delegate = self
  }
  
  
  //MARK: Adjusting view height according to keyboard
  
  @objc func keyboardWillShow(_ notification: Notification) {
    
    let keyboardHeight = getKeyboardHeight(notification)
    let keyboardY = self.view.frame.origin.y - keyboardHeight
    print(keyboardY)
    textViewBottom?.constant = -(keyboardHeight + 90)
  }
  
  @objc func keyBoardWillHide(_ notification: Notification) {
    self.view.frame.origin.y = 0
    textViewBottom?.constant = -50
  }
  
  func getKeyboardHeight(_ notification: Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.cgRectValue.height
  }
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  //MARK: Logic
  
  @objc private func moreAction() {
    let moreDetailsViewController = MoreDetailsViewController()
    if let sheet = moreDetailsViewController.sheetPresentationController {
      sheet.detents = [.medium(), .large()]
      sheet.prefersScrollingExpandsWhenScrolledToEdge = true
      sheet.prefersEdgeAttachedInCompactHeight = true
      sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
      sheet.prefersGrabberVisible = true
      sheet.preferredCornerRadius = 30
    }
    present(moreDetailsViewController, animated: true, completion: nil)
  }
  
}

extension NoteDetailViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.label
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Your Note here..."
      textView.textColor = UIColor.lightGray
    }
  }
  
}

