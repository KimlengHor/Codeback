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
    @IBOutlet weak var organizationDetailTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contactPersonLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var organizationView: UIView!
    @IBOutlet weak var linkButton: UIButton!
    
    //Variables
    var sponser: Sponser!
    var imageString: String!
    var userPref: Userpreference!
    var isForyou =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    fileprivate func setupView() {
        organizationImageView.createRoundCorner(cornerRadius: 10)
        organizationView.createRoundCorner(cornerRadius: 10)
        profileImageView.createRoundCorner(cornerRadius: self.profileImageView.frame.height / 2)
        emailButton.createRoundCorner(cornerRadius: self.emailButton.frame.height / 2)
        callButton.createRoundCorner(cornerRadius: self.callButton.frame.height / 2)
        linkButton.createRoundCorner(cornerRadius: self.linkButton.frame.height / 2)
        
        //from the database
        
        if isForyou {
            organizationNameLabel.text = userPref.titleNews
            contactPersonLabel.text = "Gregory"
            organizationDetailTextView.text = userPref.descriptionNews
            organizationImageView.image = UIImage(named: imageString)
        } else {
            organizationNameLabel.text = sponser.titleSponsor
            contactPersonLabel.text = sponser.contactPerson
            organizationDetailTextView.text = sponser.description
            organizationImageView.image = UIImage(named: imageString)
        }
    }
    
    @IBAction func emailButtonPressed(_ sender: Any) {
    }
    
    @IBAction func callButtonPressed(_ sender: Any) {
//        guard let number = URL(string: "tel://" + sponser.contactPerson) else { return }
//        UIApplication.shared.open(number)
    }
    
    @IBAction func linkButtonPressed(_ sender: Any) {
        
        if isForyou {
            if let url = URL(string: self.userPref.urlNews) {
                UIApplication.shared.open(url)
            }
        } else {
            if let url = URL(string: self.sponser.urlNews) {
                UIApplication.shared.open(url)
            }
        }
    }
}
