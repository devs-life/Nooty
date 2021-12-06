//
//  AuthVC.swift
//  Nooty
//
//  Created by Jagdeep Singh on 28/11/21.
//

import UIKit
import SwiftUI
import AuthenticationServices


class AuthVC: UIViewController {
  
  let titleLabel = UILabel()
  let titleImageView = UIImageView()
  let descLabel = UILabel()
  let appleSignInBtn = ASAuthorizationAppleIDButton(
    authorizationButtonType: .default,
    authorizationButtonStyle: UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
  )
  let skipSignInView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupViews()
  }
  
  private func setupViews(){
    view.backgroundColor = .systemBackground
    setupTitleImgView()
    setupTitleLabel()
    setupDescLabel()
    setupSOAppleSignIn()
    setupSkipSignInView()
  }
  
  private func setupTitleImgView(){
    view.addSubview(titleImageView)
    titleImageView.translatesAutoresizingMaskIntoConstraints = false
    
    titleImageView.anchor(left: nil, top: view.safeAreaLayoutGuide.topAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 90, paddingRight: nil, paddingBottom: nil)
    titleImageView.centerInView(centerX: view.centerXAnchor, centerY: nil)
    titleImageView.anchorHeightAndWidth(height: view.heightAnchor, heightConstant: nil, heightMultiplier: 0.22, width: nil, widthConstant: 250, widthMultiplier: nil)
    
    titleImageView.contentMode = .scaleAspectFill
    titleImageView.image = UIImage(systemName: "books.vertical.circle.fill")
    titleImageView.tintColor = .systemPurple
  }
  
  private func setupTitleLabel(){
    view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.anchor(left: nil, top: titleImageView.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 10, paddingRight: nil, paddingBottom: nil)
    titleLabel.centerInView(centerX: view.centerXAnchor, centerY: nil)
    titleImageView.anchorHeightAndWidth(height: nil, heightConstant: 50, heightMultiplier: nil, width: view.widthAnchor, widthConstant: nil, widthMultiplier: 0.4)
    titleLabel.text = "Nooty App"
    titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
  }
  
  private func setupDescLabel(){
    view.addSubview(descLabel)
    descLabel.translatesAutoresizingMaskIntoConstraints = false
    
    descLabel.anchor(left: nil, top: titleLabel.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 20, paddingRight: nil, paddingBottom: nil)
    descLabel.anchorHeightAndWidth(height: nil, heightConstant: 30, heightMultiplier: nil, width: view.widthAnchor, widthConstant: nil, widthMultiplier: 0.75)
    descLabel.centerInView(centerX: titleLabel.centerXAnchor, centerY: nil)
    descLabel.text = "Nooty app to keep your notes nooty"
  }
  
  private func setupSOAppleSignIn() {
    //layout apple signin
    view.addSubview(appleSignInBtn)
    appleSignInBtn.translatesAutoresizingMaskIntoConstraints = false
    appleSignInBtn.anchor(left: nil, top: descLabel.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 200, paddingRight: nil, paddingBottom: nil)
    appleSignInBtn.anchorHeightAndWidth(height: nil, heightConstant: 40, heightMultiplier: nil, width: nil, widthConstant: 200, widthMultiplier: nil)
    appleSignInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    appleSignInBtn.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
    
  }
  private func setupSkipSignInView(){
    view.addSubview(skipSignInView)
    skipSignInView.translatesAutoresizingMaskIntoConstraints = false
    skipSignInView.anchor(left: nil, top: appleSignInBtn.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 20, paddingRight: nil, paddingBottom: nil)
    
    skipSignInView.anchorHeightAndWidth(height: nil, heightConstant: 40, heightMultiplier: nil, width: nil, widthConstant: 250, widthMultiplier: nil)
    skipSignInView.centerXAnchor.constraint(equalTo: appleSignInBtn.centerXAnchor).isActive = true
    
    
    let skipLabel = UILabel()
    skipSignInView.addSubview(skipLabel)
    skipLabel.translatesAutoresizingMaskIntoConstraints = false
    
    skipLabel.anchor(left: skipSignInView.leadingAnchor, top: skipSignInView.topAnchor, right: nil, bottom: nil, paddingLeft: 20, paddingTop: 10, paddingRight: nil, paddingBottom: nil)
    skipLabel.anchorHeightAndWidth(height: nil, heightConstant: 18, heightMultiplier: nil, width: nil, widthConstant: 165, widthMultiplier: nil)
    skipLabel.text = "Wanna do signin later"
    
    let skipBtn = UIButton(type: .system)
    skipSignInView.addSubview(skipBtn)
    skipBtn.translatesAutoresizingMaskIntoConstraints = false
    
    skipBtn.anchorHeightAndWidth(height: nil, heightConstant: 16, heightMultiplier: nil, width: nil, widthConstant: nil, widthMultiplier: nil)
    skipBtn.anchor(left: skipLabel.trailingAnchor, top: skipSignInView.topAnchor, right: skipSignInView.trailingAnchor, bottom: nil, paddingLeft: -15, paddingTop: 12, paddingRight: 0, paddingBottom: nil)
    skipBtn.setTitle("Skip it", for: .normal)
    
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
  
  @objc func actionHandleAppleSignin() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  
}
extension AuthVC: ASAuthorizationControllerDelegate {
  
  // ASAuthorizationControllerDelegate function for authorization failed
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    
    print(error.localizedDescription)
    
  }
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }
      
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
      
      
      let userIdentifier = appleIDCredential.user
      let fullName = appleIDCredential.fullName
      let email = appleIDCredential.email
      
      print(idTokenString)
      print(userIdentifier)
      print(fullName)
      print(email)
    }
  }
  
  
}

extension AuthVC: ASAuthorizationControllerPresentationContextProviding {
  
  //For present window
  
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    
    return self.view.window!
    
  }
  
}

#if DEBUG
struct AuthIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> UIViewController {
    return AuthVC()
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    
  }
}

struct AuthControllerView: View {
  var body: some View {
    AuthIntegratedController().ignoresSafeArea(.all)
  }
}

struct ViewControllerPrev: PreviewProvider {
  static var previews: some View {
    AuthControllerView()
  }
}

#endif
