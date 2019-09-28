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
    
    func addContact(contact:ContactsModel){
        NetworkManager.shareInstance.callData(requestType: .post, jsonInputData: nil, path: "/contacts.json") { (responseData) in
             
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.editContactServiceManager(serviceManger: self, didAddContact: contactDetail)
                
            } catch let err {
                print("Err", err)
            }
        }
    }
    
    func updateContact(contact:ContactsModel){
        NetworkManager.shareInstance.callData(requestType: .put, jsonInputData: nil, path: "/contacts/\(contact.id!).json") { (responseData) in
             
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.editContactServiceManager(serviceManger: self, didUpdateContact: contactDetail)
                
            } catch let err {
                print("Err", err)
            }
        }
    }
}

