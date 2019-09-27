//
//  ImageViewExtension.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
public func imageFromServerURL(urlString: String) {
    self.image = nil
    URLSession.shared.dataTask(with: URL(fileURLWithPath: urlString), completionHandler: { (data, response, error) -> Void in

        if error != nil {
            print(error as Any)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            self.image = image
        })

    }).resume()
}}
