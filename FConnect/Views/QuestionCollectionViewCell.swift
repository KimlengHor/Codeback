//
//  QuestionCollectionViewCell.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

protocol QuestionButtonsDelegate {
    func buttonTapped(index: IndexPath, choice: Bool)
}

class QuestionCollectionViewCell: UICollectionViewCell {
    
    //Variables
    var questionDelegate: QuestionButtonsDelegate!
    var indexPath: IndexPath!
    let questionArray = ["Do you need place to stay?", "Do you need help with your studies?", "Do you need a ride?", "Are you hungry?", "Would you like to talk to a friend?"]
    
    //IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var questionView: UIView!
    
    override func awakeFromNib() {
        questionView.createRoundCorner(cornerRadius: 10)
        yesButton.createSpecificRoundCorner(corners: [.bottomRight], radius: 10)
        noButton.createSpecificRoundCorner(corners: [.bottomLeft], radius: 10)
    }
    
    func setupView(index: Int) {
        questionLabel.text = questionArray[index]
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        self.questionDelegate.buttonTapped(index: indexPath, choice: true)
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.questionDelegate.buttonTapped(index: indexPath, choice: false)
    }
}
