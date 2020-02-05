//
//  ViewController.swift
//  Login
//
//  Created by Elvis Alvarado on 1/26/20.
//  Copyright © 2020 Team Rocket. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        /*
         Facebook Login [START]
         */
        //FBLoginButton.self
//        let loginButton = FBLoginButton()
//
//        // Optional: Place the button in the center of your view.
//        loginButton.center = view.center
//        view.addSubview(loginButton)
        
//        if (AccessToken.current != nil) {
//          // User is logged in, do work such as go to next view controller.
//            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//                if let error = error {
//                    print(error)
//                    return
//                }
//                self.transitionToHome()
//            }
//        }
        /*
         Facebook Login [END]
         */
    }
    
    /*
     Facebook Login [START]
     */
    /*func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
      }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print(error)
            return
          }
            self.transitionToHome()
        }
      
    }*/
    /*
     Facebook Login [END]
     */
    
    /*
     Google Sign In [START]
     */
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            print("")
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            self.transitionToHome()
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    /*
    Google Sign In [END]
    */
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}

