//
//  extensionViewController.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 3/9/23.
//

import UIKit
extension ViewController {
    func presentSearchAlert(withTitle title: String?,
                            message: String?,
                            style: UIAlertController.Style,
                            completionHandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: style)
        alert.addTextField { (textField) in
            _ = ["Minsk", "Moskow", "London"]
            textField.placeholder = ""
        }
        let search = UIAlertAction(title: "Search", style: .default) { (action) in
            let textField = alert.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)
        
        alert.addAction(search)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
