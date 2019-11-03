//
//  ForyouCollectionViewCell.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

class ForyouCollectionViewCell: UICollectionViewCell {
    
    //IBOutlets
    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    //Variables
    let images = ["resource1", "resource2", "resource3", "resource4", "resource5"]
    let counselingImages = ["couns1", "couns2", "couns3", "couns4", "couns5"]
    let educationImages = ["edu1", "edu2", "edu3", "edu4", "edu5"]
    let foodImages = ["food1", "food2", "food3", "food4", "food5"]
    let transportationImages = ["trans1", "trans2", "trans3", "trans4", "trans5"]
    let homeImages = ["home1", "home2", "home3", "home4", "home5"]
    let percentages = ["95%", "75%", "55%", "40%", "35%"]
    
    override func awakeFromNib() {
        cardView.createRoundCorner(cornerRadius: 10)
        organizationImageView.createRoundCorner(cornerRadius: 10)
        percentageLabel.createRoundCorner(cornerRadius: self.percentageLabel.frame.height / 2)
        percentageLabel.clipsToBounds = true
    }
    
    func setupSponserView(sponsers: [Sponser], index: Int) {
        organizationNameLabel.text = sponsers[index].titleSponsor
        organizationImageView.image = UIImage(named: images[index])
    }
    
    func setupPrefView(userPreference: [Userpreference], index: Int, type: String) {
        organizationNameLabel.text = userPreference[index].titleNews
        switch type {
        case "food":
            organizationImageView.image = UIImage(named: foodImages[index])
        case "counseling":
            organizationImageView.image = UIImage(named: counselingImages[index])
        case "education":
            organizationImageView.image = UIImage(named: educationImages[index])
        case "home":
            organizationImageView.image = UIImage(named: homeImages[index])
        default:
            organizationImageView.image = UIImage(named: transportationImages[index])
        }
        
        percentageLabel.text = percentages[index]
    }
    
}
