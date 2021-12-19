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
    textView.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    return textView
  }()
  
  let titleField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.font = .systemFont(ofSize: 22)
    return tf
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = false
    setuptTitleField()
    setupTextView()
  }
  
  private func setuptTitleField() {
    view.addSubview(titleField)
    titleField.anchor(
      left: view.leadingAnchor,
      top: view.safeAreaLayoutGuide.topAnchor,
      right: view.trailingAnchor,
      bottom: nil,
      paddingLeft: 8,
      paddingTop: 0,
      paddingRight: 8,
      paddingBottom: 0
    )
    titleField.anchorHeightAndWidth(
      height: nil,
      heightConstant: 30,
      heightMultiplier: nil,
      width: nil,
      widthConstant: nil,
      widthMultiplier: nil
    )
  }
  
  private func setupTextView() {
    view.addSubview(textView)
    textView.anchor(
      left: view.leadingAnchor,
      top: titleField.bottomAnchor,
      right: view.trailingAnchor,
      bottom: view.bottomAnchor,
      paddingLeft: 8,
      paddingTop: 0,
      paddingRight: 8,
      paddingBottom: 0
    )
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
