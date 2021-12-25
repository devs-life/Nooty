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
    textView.isScrollEnabled = false
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
  
  var extraHeight: CGFloat = 100
  
  lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + extraHeight)
  
  lazy var scrollView: UIScrollView = {
      let sView = UIScrollView(frame: .zero)
      sView.backgroundColor = .systemBackground
      sView.frame = self.view.bounds
      sView.contentSize = contentViewSize
      return sView
  }()
  
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
    setupScrollView()
    setupMoreButton()
    setupSeperatorView()
    setuptTitleField()
    setupTextView()
  }
  
  private func setupScrollView() {
      view.addSubview(scrollView)
      scrollView.addSubview(containerView)
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
      bottom: containerView.bottomAnchor,
      paddingLeft: 15,
      paddingTop: 10,
      paddingRight: 8,
      paddingBottom: 0
    )
    
    textView.delegate = self
  }
  
  /// Logic:-
  
  @objc private func moreAction() {
    print("morePressed")
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

/// SwiftUI Previews
#if DEBUG
struct NoteDetailIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> UINavigationController {
    return UINavigationController(rootViewController: NoteDetailViewController())
  }
  
  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    
  }
}

struct NoteDetailControllerView: View {
  var body: some View {
    NoteDetailIntegratedController().ignoresSafeArea(.all)
  }
}

struct NoteDetailViewControllerPrev: PreviewProvider {
  static var previews: some View {
    Group {
      NoteDetailControllerView().colorScheme(.light)
      NoteDetailControllerView().colorScheme(.dark)
    }
  }
}
#endif
