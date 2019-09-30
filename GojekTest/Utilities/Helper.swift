//
//  Helper.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class Helper{
    static func showAlert(title:String, subtitle:String){
        DispatchQueue.main.async(execute: {
            
            let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            
            guard let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            
            currentWindowScene.windows.last!.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
}
