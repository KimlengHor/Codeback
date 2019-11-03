//
//  ShowAlertController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

//"Missing requirements"
//"Please make sure you fill in all requirements."

func showAlert(viewController: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))

    viewController.present(alert, animated: true)
}

func showAlertToUrl(viewController: UIViewController, title: String, message: String, url: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "Go", style: .default, handler: { (_) in
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }))
    viewController.present(alert, animated: true)
}
