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
       // setupSOAppleSignIn()
    }
    
    private func setupTitleImgView(){
        view.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.anchor(left: view.leadingAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: nil, bottom: nil, paddingLeft: 20, paddingTop: 50, paddingRight: 0, paddingBottom: 0, height: nil, heightConstant: 200, heightMultiplier: nil, width: nil, widthConstant: 200, widthMultiplier: nil)
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = UIImage(systemName: "books.vertical.circle.fill")
        titleImageView.tintColor = .systemPurple
        
    }
    
    private func setupTitleLabel(){
        
    }
    
    private func setupDescLabel(){
        
    }
    
    private func setupSOAppleSignIn() {
        //layout apple signin
        //view.addSubview(appleSignInBtn)
        appleSignInBtn.translatesAutoresizingMaskIntoConstraints = false
        
        //signInBtn.a
        appleSignInBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        
        appleSignInBtn.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)

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


struct AuthIntegratedController: UIViewControllerRepresentable {
  
  func makeUIViewController(context: Context) -> AuthVC {
    return AuthVC()
  }
  
  func updateUIViewController(_ uiViewController: AuthVC, context: Context) {
    
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
