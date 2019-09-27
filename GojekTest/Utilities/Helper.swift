//
//  Helper.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation
import UIKit

class Helper{
    static func showAlert(title:String, subtitle:String){
        DispatchQueue.main.async(execute: {
            
            let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
}
