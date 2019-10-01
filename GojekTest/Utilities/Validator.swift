//
//  Validator.swift
//  GojekTest
//
//  Created by Sourav on 01/10/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation

func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
}
