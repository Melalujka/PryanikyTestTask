//
//  UIViewController+Ext.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

extension UIViewController {
    
    typealias AlertCallBack = (()->())

    func showSimpleAlertView(title: String? = "", message: String) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
}
