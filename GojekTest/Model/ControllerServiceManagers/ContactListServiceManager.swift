//
//  ContactListServiceManager.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation

protocol ContactListServiceManagerDelegate : class{
    func contactListServiceManager(serviceManger: ContactListServiceManager, didFetchingContacts data: [ContactsModel]?)
    func contactListServiceManager(serviceManger: ContactListServiceManager, didFetchContactDetail data: ContactDetailModel?)
}

class ContactListServiceManager {
    weak var delegate: ContactListServiceManagerDelegate?
    
    func getContactList(){
        NetworkManager.shareInstance.callData(requestType: .get, jsonInputData: nil, path: "/contacts.json") { (responseData) in
             
            do {
                let decoder = JSONDecoder()
                let contacts = try decoder.decode([ContactsModel].self, from: responseData)
                self.delegate?.contactListServiceManager(serviceManger: self, didFetchingContacts: contacts)
                
            } catch let err {
                print("Err", err)
            }
        }
    }
    
    func getContactDetail(contact:ContactsModel){
        NetworkManager.shareInstance.callData(requestType: .get, jsonInputData: nil, path: "/contacts/\(contact.id!).json") { (responseData) in
             
            do {
                let decoder = JSONDecoder()
                let contactDetail = try decoder.decode(ContactDetailModel.self, from: responseData)
                self.delegate?.contactListServiceManager(serviceManger: self, didFetchContactDetail: contactDetail)
                
            } catch let err {
                print("Err", err)
            }
        }
    }
}
