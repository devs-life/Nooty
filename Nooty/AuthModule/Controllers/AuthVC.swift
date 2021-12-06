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
    let appleSignInBtn = ASAuthorizationAppleIDButton()
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
    }
    
    private func setupTitleImgView(){
        view.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
      
        titleImageView.anchor(left: nil, top: view.safeAreaLayoutGuide.topAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 70, paddingRight: nil, paddingBottom: nil)
        titleImageView.centerInView(centerX: view.centerXAnchor, centerY: nil)
      titleImageView.anchorHeightAndWidth(height: view.heightAnchor, heightConstant: 200, heightMultiplier: 0.25, width: nil, widthConstant: 200, widthMultiplier: nil)
        
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = UIImage(systemName: "books.vertical.circle.fill")
        titleImageView.tintColor = .systemPurple
        
    }
    
    private func setupTitleLabel(){
      view.addSubview(titleLabel)
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      
      titleLabel.anchor(left: nil, top: titleImageView.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 20, paddingRight: nil, paddingBottom: nil)
      titleLabel.centerInView(centerX: view.centerXAnchor, centerY: nil)
      titleImageView.anchorHeightAndWidth(height: nil, heightConstant: 50, heightMultiplier: nil, width: view.widthAnchor, widthConstant: nil, widthMultiplier: 0.4)
      titleLabel.text = "Nooty App"
      titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
    
    private func setupDescLabel(){
      view.addSubview(descLabel)
      descLabel.translatesAutoresizingMaskIntoConstraints = false
      
      descLabel.anchor(left: nil, top: titleLabel.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 20, paddingRight: nil, paddingBottom: nil)
      descLabel.anchorHeightAndWidth(height: nil, heightConstant: 30, heightMultiplier: nil, width: view.widthAnchor, widthConstant: nil, widthMultiplier: 0.6)
      descLabel.centerInView(centerX: titleLabel.centerXAnchor, centerY: nil)
      descLabel.text = "Nooty app to keep your notes nooty"
    }
    
    private func setupSOAppleSignIn() {
        //layout apple signin
        view.addSubview(appleSignInBtn)
        appleSignInBtn.translatesAutoresizingMaskIntoConstraints = false
      appleSignInBtn.anchor(left: nil, top: descLabel.bottomAnchor, right: nil, bottom: nil, paddingLeft: nil, paddingTop: 50, paddingRight: nil, paddingBottom: nil)
      appleSignInBtn.anchorHeightAndWidth(height: nil, heightConstant: 40, heightMultiplier: nil, width: nil, widthConstant: 200, widthMultiplier: nil)
      appleSignInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //signInBtn.a
        
        appleSignInBtn.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)

      }
  private func setupSkipSignInView(){
    
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

       // ASAuthorizationControllerDelegate function for successful authorization

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement

            let appleId = appleIDCredential.user
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            let appleUserLastName = appleIDCredential.fullName?.familyName
            let appleUserEmail = appleIDCredential.email

            //Write your code

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password

            //Write your code

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
