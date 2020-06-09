//
//  UIViewController+Alerts.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(text: String) {
        let alert = UIAlertController(title: text,
                                      message: nil,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSettingsAlert(text: String, subtext: String? = nil) {
        
        let alert = UIAlertController(title: text,
                                      message: subtext,
                                      preferredStyle: .alert)
        let close = UIAlertAction(title: "Close",
                                  style: .default,
                                  handler: nil)
        let openSettings = UIAlertAction(title: "Settings",
                                         style: .default) { _ in
                                            UIApplication.shared.open(.settings)
                                            
        }
        alert.addAction(close)
        alert.addAction(openSettings)
        alert.preferredAction = openSettings
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension URL {
    static let settings: URL = URL(string: UIApplication.openSettingsURLString)!
}

