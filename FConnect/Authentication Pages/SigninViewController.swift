//
//  SigninViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var signinCardView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotificationObservers()
        setupView()
    }
    
    fileprivate func setupView() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        //add tap gesture recognizer
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissTap)
        
        signinCardView.createRoundCorner(cornerRadius: 10)
        signinCardView.createShadow(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        emailTextField.setupTheBottomBorder()
        passwordTextField.setupTheBottomBorder()
        
        loginButton.createRoundCorner(cornerRadius: self.loginButton.frame.height / 2)
    }
    
    fileprivate func userSignin() {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            startSpinnerAnimation(view: self.view)
            Auth.auth().signIn(withEmail: email, password: password) { (data, error) in
                DispatchQueue.main.async {
                    
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                    
                    if let error = error {
                        //print("There is an error", error)
                        showAlert(viewController: self, title: "Login error", message: error.localizedDescription)
                        return
                    } else {
                        let discoverNavigationVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DiscoverNavigationVC")
                        discoverNavigationVC.modalPresentationStyle = .fullScreen
                        self.present(discoverNavigationVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - signinCardView.frame.origin.y - signinCardView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 15)
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        userSignin()
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        //to sign up view
        let signupVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignupVC") as! SignupViewController
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
}
