//
//  ContactDetailViewController.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailViewController: UIViewController {

    private var contactDetailView : ContactDetailView?
    private let serviceManager = ContactDetailServiceManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        contactDetailView = self.view as? ContactDetailView
        contactDetailView?.delegate = self
        
        // Do any additional setup after loading the view.
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
    func contactDetailView(_ view: ContactDetailView, editContact contact: ContactDetailModel) {
        DispatchQueue.main.async(execute: { () -> Void in
            let vc = UIStoryboard.init(name: "Contact", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditContactViewController") as? EditContactViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.configContactDetail(contactDetail: contact)
        })
    }
    
    func contactDetailView(_ view: ContactDetailView, didSelectCall phoneNumber: String) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
            else {
                Helper.showAlert(title: "Error", subtitle: "Unable to make call")
            }
        }
    }
    
    func contactDetailView(_ view: ContactDetailView, didSelectMessage phoneNumber: String) {
        if MFMessageComposeViewController.canSendText() {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self

            composeVC.recipients = [phoneNumber]
            composeVC.body = ""
            
            self.present(composeVC, animated: true, completion: nil)
        }
        else {
            Helper.showAlert(title: "Error", subtitle: "Unable to send message")
        }
    }
    
    func contactDetailView(_ view: ContactDetailView, didSelectEmail email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("", isHTML: true)

            present(mail, animated: true)
        } else {
            Helper.showAlert(title: "Error", subtitle: "Unable to send email")
        }
    }
    
    func contactDetailView(_ view: ContactDetailView, didSelectFavourite contact: ContactDetailModel) {
        self.serviceManager.updateFavourite(contact: contact)
        
        Helper.showAlert(title: "Success", subtitle: "Favourite updated successfully.")
    }
}

extension ContactDetailViewController:MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ContactDetailViewController:MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

