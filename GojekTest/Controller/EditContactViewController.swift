//
//  EditContactViewController.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {

    private var editContactView : EditContactView?
    private let serviceManager = EditContactServiceManger()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        serviceManager.delegate = self
        
        editContactView = self.view as? EditContactView
        editContactView?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditContactViewController:EditContactViewDelegate {
    func editContactView(_ view: EditContactView, addContact contact:ContactsModel){
        serviceManager.addContact(contact: contact)
    }
    
    func editContactView(_ view: EditContactView, updateContact contact:ContactsModel){
        serviceManager.updateContact(contact: contact)
    }
}

extension EditContactViewController:EditContactServiceManagerDelegate{
    
    func editContactServiceManager(serviceManger: EditContactServiceManger, didAddContact contact: ContactDetailModel?) {
        
    }
    
    func editContactServiceManager(serviceManger: EditContactServiceManger, didUpdateContact contact: ContactDetailModel?) {
        
    }
}
