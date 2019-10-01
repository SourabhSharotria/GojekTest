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
    func editContactServiceManager(serviceManger: EditContactServiceManger, didDeleteContact contact: ContactDetailModel?)
}

class EditContactServiceManger {
    
    weak var delegate: EditContactServiceManagerDelegate?
    
    func addContact(contact:ContactDetailModel){
        
        let parameters = ["contact": ["first_name": contact.first_name ?? "",
        "last_name": contact.last_name ?? "",
        "email":contact.email ?? "",
        "phone_number":contact.phone_number ?? "",
        "favorite":contact.favorite ?? false]] as [String : Any]
                        
        NetworkManager.shareInstance.uploadFileData(requestType: .post, params: parameters, path: "/contacts.json", filePath: contact.profile_pic ?? "") { (responseData) in
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                
                self.delegate?.editContactServiceManager(serviceManger: self, didAddContact: contactDetail)
            } catch let err {
                print("Error", err)
            }
        }
    }
    
    func updateContact(contact:ContactDetailModel){
        
        let parameters = ["contact":["id": contact.id ?? "",
        "first_name": contact.first_name ?? "",
        "last_name": contact.last_name ?? "",
        "email":contact.email ?? "",
        "phone_number":contact.phone_number ?? "",
        "favorite":contact.favorite ?? false]] as [String : Any]
                
        NetworkManager.shareInstance.uploadFileData(requestType: .put, params: parameters, path: "/contacts/\(contact.id!).json", filePath: contact.profile_pic ?? "") { (responseData) in
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                
                self.delegate?.editContactServiceManager(serviceManger: self, didUpdateContact: contactDetail)
            } catch let err {
                print("Error", err)
            }
        }
    }
    
    func deleteContact(contact:ContactDetailModel){
        
        let parameters = ["contact":["id": contact.id ?? "",
        "first_name": contact.first_name ?? "",
        "last_name": contact.last_name ?? "",
        "email":contact.email ?? "",
        "phone_number":contact.phone_number ?? "",
        "favorite":contact.favorite ?? false]] as [String : Any]
        
        NetworkManager.shareInstance.callData(requestType: .delete, params: parameters, path: "/contacts/\(contact.id!).json") { (responseData) in
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.editContactServiceManager(serviceManger: self, didDeleteContact: contactDetail)
                
            } catch let err {
                print("Error", err)
            }
        }
    }
}

