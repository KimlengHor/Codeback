//
//  SignupViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var showPasswordImageView: UIImageView!
    @IBOutlet weak var signupCardView: UIView!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    
    //Variables
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNotificationObservers()
    }
    
    func setupView() {
        
        //add tap gesture recognizer
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissTap)
        
        signupButton.createRoundCorner(cornerRadius: self.signupButton.frame.height / 2)
        signupCardView.createRoundCorner(cornerRadius: 10)
        
        //add tap gesture for showPassword
        let showPassTap = UITapGestureRecognizer(target: self, action: #selector(showPassword))
        showPasswordImageView.addGestureRecognizer(showPassTap)
        showPasswordImageView.isUserInteractionEnabled = true
        
        emailTextField.setupTheBottomBorder()
        passwordTextField.setupTheBottomBorder()
        firstnameTextField.setupTheBottomBorder()
        lastnameTextField.setupTheBottomBorder()
        universityTextField.setupTheBottomBorder()
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
        let bottomSpace = view.frame.height - signupCardView.frame.origin.y - signupCardView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 15)
    }
    
    //after create a new user, users document will add a new document
    fileprivate func saveInfoToFirestore() {
        uid = Auth.auth().currentUser?.uid ?? ""
        let docData: [String: Any] = [
            "addressUser": "",
            "distanceNumber": "",
            "firstName": firstnameTextField.text ?? "",
            "lastName": lastnameTextField.text ?? "",
            "paypallAcc": "",
            "phoneNumber": "",
            "questionAnswer": [Any]()
        ]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error {
                print("Fail to add to the database ", error)
                return
            }
        }
    }
    
    fileprivate func userSignup() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            startSpinnerAnimation(view: self.view)
            Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
                DispatchQueue.main.async {
                    
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                    
                    if let error = error {
                        //print("There is an error", error)
                        showAlert(viewController: self, title: "Signup error", message: error.localizedDescription)
                        return
                    } else {
                        self.saveInfoToFirestore()
                        let questionVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuestionVC") as! QuestionViewController
                        questionVC.isSignup = true
                        questionVC.uid = self.uid
                        self.navigationController?.pushViewController(questionVC, animated: true)
                    }
                }
            }
        }
    }
    
    @objc fileprivate func showPassword() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        userSignup()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
