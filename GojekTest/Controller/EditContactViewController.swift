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
    var imagePicker = UIImagePickerController()
    var selectedFilePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        serviceManager.delegate = self
        
        editContactView = self.view as? EditContactView
        editContactView?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func configContactDetail(contactDetail:ContactDetailModel?) {
        
        DispatchQueue.main.async {
            self.editContactView?.updateContactDetail(contactDetail: contactDetail)
        }
    }
    
    private func selectLibraryImage() {

        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
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
    func editContactView(_ view: EditContactView, addContact contact:ContactDetailModel){
        serviceManager.addContact(contact: contact)
    }
    
    func editContactView(_ view: EditContactView, updateContact contact:ContactDetailModel){
        serviceManager.updateContact(contact: contact)
    }
    
    func editContactView(_ view: EditContactView, deleteContact contact:ContactDetailModel){
        serviceManager.deleteContact(contact: contact)
    }
    
    func editContactView(selectLibraryImage view: EditContactView){
        self.selectLibraryImage()
    }
}
 
extension EditContactViewController:EditContactServiceManagerDelegate{
    
    func editContactServiceManager(serviceManger: EditContactServiceManger, didAddContact contact: ContactDetailModel?) {
        
    }
    
    func editContactServiceManager(serviceManger: EditContactServiceManger, didUpdateContact contact: ContactDetailModel?) {
        
    }
}

extension EditContactViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")

        // extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            let imageData = pickedImage.jpegData(compressionQuality: 0.75)
            try! imageData?.write(to: imagePath!)
            
            self.editContactView?.updateContactProfile(filePath: imagePath?.path)
        }
        
        self.dismiss(animated: true, completion: { () -> Void in

        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

