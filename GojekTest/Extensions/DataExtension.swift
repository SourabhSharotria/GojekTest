//
//  DataExtension.swift
//  GojekTest
//
//  Created by Sourav on 29/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation

extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

