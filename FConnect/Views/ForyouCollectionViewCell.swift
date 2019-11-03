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
    let images = ["counseling", "housing", "resource", "connecting", "activity"]
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
    
    func setupPrefView(userPreference: [Userpreference], index: Int) {
        organizationNameLabel.text = userPreference[index].titleNews
        organizationImageView.image = UIImage(named: images[index])
        percentageLabel.text = percentages[index]
    }
    
}
