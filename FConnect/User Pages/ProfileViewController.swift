//
//  ProfileViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var myWalletView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    fileprivate func setupView() {
        questionView.createRoundCorner(cornerRadius: self.questionView.frame.height / 2)
        myWalletView.createRoundCorner(cornerRadius: self.myWalletView.frame.height / 2)
        profileImageView.createRoundCorner(cornerRadius: self.profileImageView.frame.height / 2)
        
        let questionTap = UITapGestureRecognizer(target: self, action: #selector(showQuestionVC))
        questionView.addGestureRecognizer(questionTap)
        questionView.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func showQuestionVC() {
        let questionVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuestionVC")
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsVC")
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
