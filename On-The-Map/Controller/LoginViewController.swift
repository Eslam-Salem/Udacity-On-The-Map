//
//  ViewController.swift
//  On-The-Map
//
//  Created by Eslam  on 4/5/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var userNameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var signupButton : UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func loginTapped () {
        
        setLoggingIn(true)
        UdacityClient.login(username: userNameTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    @IBAction func signupTapped () {
        
         setLoggingIn(true)
         let app = UIApplication.shared
         app.openURL(URL(string: "https://auth.udacity.com/sign-up")!)
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {

        setLoggingIn(false)
        
        if success{
            
            self.performSegue(withIdentifier: "loggedIn", sender: nil)
        } else {
            guard let error = error else {
                return
            }
            raiseAlertView(withTitle: "Login Failure", withMessage: error .localizedDescription)
        }
    }
    

    
    func setLoggingIn(_ loggingIn: Bool) {
        
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        userNameTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        signupButton.isEnabled = !loggingIn
    }
    
}



extension UIViewController {
    
    func raiseAlertView(withTitle: String, withMessage: String) {
        
            let alertController = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
             alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
    }
}
