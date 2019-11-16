//
//  OrganizationDetailViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

class OrganizationDetailViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contactPersonLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var organizationView: UIView!
    @IBOutlet weak var linkButton: UIButton!
    
    //Variables
    var recruiter: Recruiter!
    var imageString: String!
    var userPref: Userpreference!
    var isForyou =  false
    let personImages = ["eunice", "kimleng", "kimlong", "cheng", "shafie"]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    fileprivate func setupView() {
        organizationImageView.createRoundCorner(cornerRadius: 10)
        organizationView.createRoundCorner(cornerRadius: 10)
        profileImageView.createRoundCorner(cornerRadius: self.profileImageView.frame.height / 2)
        emailButton.createRoundCorner(cornerRadius: self.emailButton.frame.height / 2)
        linkButton.createRoundCorner(cornerRadius: self.linkButton.frame.height / 2)
        
        //from the database
        
        if isForyou {
            organizationNameLabel.text = userPref.titleNews
            organizationImageView.image = UIImage(named: imageString)
        } else {
            organizationNameLabel.text = recruiter.name
            contactPersonLabel.text = recruiter.companyName
            profileImageView.image = UIImage(named: personImages[index])
            organizationImageView.image = UIImage(named: imageString)
        }
    }
    
    @IBAction func emailButtonPressed(_ sender: Any) {
        if let url = URL(string: "mailto:\(self.recruiter.email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func linkButtonPressed(_ sender: Any) {
        
        if isForyou {
            if let url = URL(string: self.userPref.urlNews) {
                UIApplication.shared.open(url)
            }
        } else {
            if let url = URL(string: self.recruiter.linkedin) {
                UIApplication.shared.open(url)
            }
        }
    }
}
