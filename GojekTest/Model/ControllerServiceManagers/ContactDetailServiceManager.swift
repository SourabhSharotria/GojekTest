//
//  ContactDetailServiceManager.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation

protocol ContactDetailServiceManagerDelegate : class{
    func contactDetailServiceManager(serviceManger: ContactDetailServiceManager, didUpdateFavourite data: ContactDetailModel)
}

class ContactDetailServiceManager {
    
    weak var delegate: ContactDetailServiceManagerDelegate?
    
    func updateFavourite(contact:ContactDetailModel) {
        
        let parameters = ["contact":["first_name": contact.first_name ?? "",
        "last_name": contact.last_name ?? "",
        "email":contact.email ?? "",
        "phone_number":contact.phone_number ?? "",
        "favorite":contact.favorite ?? false]] as [String : Any]
        
        NetworkManager.shareInstance.callData(requestType: .put, params: parameters, path: "/contacts/\(contact.id!).json") { (responseData) in
            
        }
    }
    
}
