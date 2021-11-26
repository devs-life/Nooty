//
//  ViewController.swift
//  Nooty
//
//  Created by Ajay on 26/11/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemRed
  }
}

struct ViewIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> ViewController {
    return ViewController()
  }
  
  func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    
  }
}

struct ViewControllerView: View {
    var body: some View {
      ViewIntegratedController().ignoresSafeArea(.all)
    }
}

struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
      ViewControllerView()
    }
}
