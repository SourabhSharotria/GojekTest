//
//  EditContactServiceManger.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation

protocol EditContactServiceManagerDelegate : class{
    func editContactServiceManager(serviceManger: EditContactServiceManger, didAddContact contact: ContactDetailModel?)
    func editContactServiceManager(serviceManger: EditContactServiceManger, didUpdateContact contact: ContactDetailModel?)
}

class EditContactServiceManger {
    
    weak var delegate: EditContactServiceManagerDelegate?
    
    func addContact(contact:ContactDetailModel){
        
        let parameters = ["first_name": contact.first_name ?? "harsh",
        "last_name": contact.last_name ?? "parh",
        "email":contact.email ?? "harsh@123.com",
        "phone_number":contact.phone_number ?? "989842223244",
        "favorite":contact.favorite ?? false] as [String : Any]
        
        let jsonDict = ["contact" : parameters]
        
        NetworkManager.shareInstance.createRequest(requestType:.post, params: jsonDict, path: "/contacts.json", filePath: contact.profile_pic ?? "") { (responseData) in
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.editContactServiceManager(serviceManger: self, didAddContact: contactDetail)

            } catch let err {
                print("Err", err)
            }
        }
    }
    
    func updateContact(contact:ContactDetailModel){
        
        let parameters = ["id": contact.id ?? "",
        "first_name": contact.first_name ?? "",
        "last_name": contact.last_name ?? "",
        "email":contact.email ?? "",
        "phone_number":contact.phone_number ?? "",
        "favorite":contact.favorite ?? false] as [String : Any]
        
         let jsonDict = ["contact" : parameters]
        
        NetworkManager.shareInstance.createRequest(requestType:.put, params: jsonDict, path: "/contacts/\(contact.id!).json", filePath: contact.profile_pic ?? "") { (responseData) in
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.editContactServiceManager(serviceManger: self, didAddContact: contactDetail)
                
            } catch let err {
                print("Err", err)
            }
        }
        
        
    }
    
    func deleteContact(contact:ContactDetailModel){
        
        NetworkManager.shareInstance.callData(requestType: .delete, params: nil, path: "DELETE /contacts/\(contact.id!).json") { (responseData) in
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.editContactServiceManager(serviceManger: self, didAddContact: contactDetail)
                
            } catch let err {
                print("Err", err)
            }
        }
        
    }
}

