//
//  AppDelegate.swift
//  Nooty
//
//  Created by Ajay on 21/12/21.
//

import UIKit
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    if let userId = UserDefaults.standard.string(forKey: UserDefaultKeys.userIdKey) {
      
      let appleIdProvider = ASAuthorizationAppleIDProvider()
      appleIdProvider.getCredentialState(forUserID: userId) { credentialState, err in
        
        switch credentialState {
          case .authorized:
            DispatchQueue.main.async { self.showNotebooksViewController() }
            break // The Apple ID credential is valid.
          case .revoked, .notFound:
            // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
            DispatchQueue.main.async { self.showLoginViewController() }
          default:
            break
        }
        
      }
    } else {
      showLoginViewController()
    }
    return true
  }
  
  private func showLoginViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = AuthViewController()
    window?.makeKeyAndVisible()
  }
  
  private func showNotebooksViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = NotebooksViewController()
    window?.makeKeyAndVisible()
  }
}
