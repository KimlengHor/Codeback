//
//  CreateSpinner.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    spinner.createRoundCorner(cornerRadius: 10)
    spinner.backgroundColor = #colorLiteral(red: 0.9488552213, green: 0.9487094283, blue: 0.9693081975, alpha: 1)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.hidesWhenStopped = true
    return spinner
}()

func startSpinnerAnimation(view: UIView) {
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    spinner.startAnimating()
}

