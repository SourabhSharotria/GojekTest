//
//  ContactListViewController.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    private var contactsListView : ContactListView?
    private let serviceManager = ContactListServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contacts"
        serviceManager.delegate = self
        contactsListView = self.view as? ContactListView
        contactsListView?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getContactList()
    }

    private func getContactList() {
        serviceManager.getContactList()
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
extension ContactListViewController:ContactListServiceManagerDelegate{
    func contactListServiceManager(serviceManger: ContactListServiceManager, didFetchingContacts data: [ContactsModel]?){
        self.contactsListView?.updateSections(contacts: data)
    }
    func contactListServiceManager(serviceManger: ContactListServiceManager, didFetchContactDetail data: ContactDetailModel?){
        DispatchQueue.main.async(execute: { () -> Void in
            let vc = UIStoryboard.init(name: "Contact", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.configContactDetail(contactDetail: data)
        })
    }
}

extension ContactListViewController:ContactListViewDelegate{
    func contactListView(addContact view: ContactListView) {
        DispatchQueue.main.async(execute: { () -> Void in
            let vc = UIStoryboard.init(name: "Contact", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditContactViewController") as? EditContactViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.configContactDetail(contactDetail: nil)
        })
    }
    
    func contactListView(_ view: ContactListView, didSelectContact contact:ContactsModel){
        serviceManager.getContactDetail(contact: contact)
    }
    
    func didSelectMessage(cell didSelectMessage: ContactDetailView){
        
    }
    
    func didSelectCall(cell didSelectCall: ContactDetailView){
        
    }
    
    func didSelectEmail(cell didSelectEmail: ContactDetailView){
        
    }
    
    func contactDetailView(_ view: ContactDetailView, didSelectFavourite val: Bool){
        
    }
}
