//
//  SettingViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var paypalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    fileprivate func setupView() {
        usernameTextField.setupTheBottomBorder()
        emailTextField.setupTheBottomBorder()
        phoneNumberTextField.setupTheBottomBorder()
        addressTextField.setupTheBottomBorder()
        paypalTextField.setupTheBottomBorder()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
