//
//  AuthVC.swift
//  Nooty
//
//  Created by Jagdeep Singh on 28/11/21.
//

import UIKit
import SwiftUI
import AuthenticationServices

class AuthViewController: UIViewController {

  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Nooty App"
    label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    label.textAlignment = .center
    return label
  }()
  
  let titleImageView : UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "books.vertical.circle.fill"))
    imageView.contentMode = .scaleAspectFill
    imageView.tintColor = .systemPurple
    return imageView
  }()
  
  let descLabel : UILabel = {
    let label = UILabel()
    label.text = "Nooty app to keep your notes nooty"
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .center
    return label
  }()
  let appleSignInBtn = ASAuthorizationAppleIDButton(
    authorizationButtonType: .default,
    authorizationButtonStyle: UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
  )
  let skipSignInView = SkipSignInView(frame: .zero)
  
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
    
    titleImageView.anchor(left: nil, top: view.safeAreaLayoutGuide.topAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 90, paddingRight: nil, paddingBottom: nil)
    titleImageView.centerInView(centerX: view.centerXAnchor, centerY: nil)
    titleImageView.anchorHeightAndWidth(height: view.heightAnchor, heightConstant: nil, heightMultiplier: 0.22, width: nil, widthConstant: 200, widthMultiplier: nil)
  }
  
  private func setupTitleLabel(){
    view.addSubview(titleLabel)
    
    titleLabel.anchor(left: nil, top: titleImageView.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 10, paddingRight: nil, paddingBottom: nil)
    titleLabel.centerInView(centerX: view.centerXAnchor, centerY: nil)
    
  }
  
  private func setupDescLabel(){
    view.addSubview(descLabel)
    
    descLabel.anchor(left: nil, top: titleLabel.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 20, paddingRight: nil, paddingBottom: nil)
    descLabel.anchorHeightAndWidth(height: nil, heightConstant: 30, heightMultiplier: nil, width: view.widthAnchor, widthConstant: nil, widthMultiplier: 0.75)
    descLabel.centerInView(centerX: titleLabel.centerXAnchor, centerY: nil)
  }
  
  private func setupSOAppleSignIn() {
    //layout apple signin
    view.addSubview(appleSignInBtn)
    appleSignInBtn.anchor(left: nil, top: descLabel.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 200, paddingRight: nil, paddingBottom: nil)
    appleSignInBtn.anchorHeightAndWidth(height: nil, heightConstant: 40, heightMultiplier: nil, width: nil, widthConstant: 200, widthMultiplier: nil)
    appleSignInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    appleSignInBtn.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
    
  }
  
  private func setupSkipSignInView(){
    view.addSubview(skipSignInView)
    skipSignInView.anchor(left: nil, top: appleSignInBtn.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 20, paddingRight: nil, paddingBottom: nil)
    
    skipSignInView.anchorHeightAndWidth(height: nil, heightConstant: 40, heightMultiplier: nil, width: nil, widthConstant: 250, widthMultiplier: nil)
    skipSignInView.centerXAnchor.constraint(equalTo: appleSignInBtn.centerXAnchor).isActive = true
    skipSignInView.delegate = self
  }
  
  @objc private func actionHandleAppleSignin() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  private func saveToUserDefaults(
    token: String?,
    userId: String?,
    email: String?,
    fullName: String?
  ) {
    UserDefaults.standard.set(token, forKey: UserDefaultKeys.tokenKey)
    UserDefaults.standard.set(userId, forKey: UserDefaultKeys.userIdKey)
    UserDefaults.standard.set(email, forKey: UserDefaultKeys.userEmailKey)
    UserDefaults.standard.set(fullName, forKey: UserDefaultKeys.userFullName)
  }
  
  private func presentNotebooksViewController() {
    let vc = NotebooksViewController()
    let navVC = UINavigationController(rootViewController: vc)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }
  
}
extension AuthViewController: ASAuthorizationControllerDelegate {
  
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
      
      guard let token = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
      
      let userId = appleIDCredential.user
      let email = appleIDCredential.email
      let givenName = appleIDCredential.fullName?.givenName ?? ""
      let familyName = appleIDCredential.fullName?.familyName ?? ""
      let fullNameString = givenName + " " + familyName
      saveToUserDefaults(token: token, userId: userId, email: email, fullName: fullNameString)
      presentNotebooksViewController()
    }
  }
}

extension AuthViewController: SkipSignInViewDelegate {
  func navigateToNotebooks() {
    self.presentNotebooksViewController()
  }
  
  
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
  
  //For present window
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}

#if DEBUG
struct AuthIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> UIViewController {
    return AuthViewController()
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
