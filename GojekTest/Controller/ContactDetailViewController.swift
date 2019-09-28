//
//  ContactDetailViewController.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    private var contactDetailView : ContactDetailView?
    private let serviceManager = ContactDetailServiceManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        contactDetailView = self.view as? ContactDetailView
        contactDetailView?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    func configContactDetail(contactDetail:ContactDetailModel?) {
        
        guard contactDetail != nil else {
            return
        }
        
        DispatchQueue.main.async {
            self.contactDetailView?.updateContactDetail(contactDetail: contactDetail!)
        }
        
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
extension ContactDetailViewController:ContactDetailViewDelegate {
    func contactDetailView(_ view: ContactDetailView, didSelectContact contact:ContactsModel){
        
    }
}
