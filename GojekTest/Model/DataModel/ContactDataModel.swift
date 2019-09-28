//
//  ContactDataModel.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation

struct ContactsModel: Codable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var profile_pic:String?
    var favorite: Bool?
    var url:String?
}

struct ContactDetailModel: Codable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var profile_pic:String?
    var phone_number: String?
    var favorite: Bool?
    var url:String?
    var created_at:String?
    var updated_at:String?
}

