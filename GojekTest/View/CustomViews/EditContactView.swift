//
//  EditContactView.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

protocol EditContactViewDelegate:class {
    func editContactView(_ view: EditContactView, addContact contact:ContactDetailModel)
    func editContactView(_ view: EditContactView, updateContact contact:ContactDetailModel)
    func editContactView(selectLibraryImage view: EditContactView)
    func editContactView(_ view: EditContactView, deleteContact contact:ContactDetailModel)
}

class EditContactView: UIView {

    @IBOutlet weak var editContactTableView: UITableView!
    var contactDetail:ContactDetailModel!
    var contactTableArray = [ContactDetail]()
    var isEditing = false
    
    weak var delegate:EditContactViewDelegate?
    
    override func awakeFromNib() {
        self.configNavBarButton()
        self.configTableView()
    }
    
    private func configTableView() {
        
        self.editContactTableView.estimatedRowHeight = 80.0
        self.editContactTableView.rowHeight = UITableView.automaticDimension
        self.editContactTableView.sectionIndexColor = .gray
        
        self.editContactTableView.registerCell(EditContactImageTableViewCell.self)
        self.editContactTableView.registerCell(ContactDescriptionTableViewCell.self)
    }
    
    private func configNavBarButton() {
        self.getViewController()!.navigationItem.rightBarButtonItem = nil
        let backButton = UIBarButtonItem(image: nil, style: .plain, target: self, action:#selector(addContactAction))
        backButton.title = "Done"
        // backButton.setBackgroundImage(UIImage(named: ""), for: <#T##UIControl.State#>, barMetrics: <#T##UIBarMetrics#>)
        self.getViewController()!.navigationItem.rightBarButtonItem = backButton
    }
    
    @objc private func addContactAction(){
        if self.contactDetail.first_name == "" && self.contactDetail.last_name == "" && self.contactDetail.email == "" && self.contactDetail.phone_number == "" {
            delegate?.editContactView(self, deleteContact: self.contactDetail)
            return
        }
        else if isEditing {
            delegate?.editContactView(self, updateContact: self.contactDetail)
        }
        else {
            delegate?.editContactView(self, addContact: self.contactDetail)
        }
    }
    
    func updateContactDetail(contactDetail:ContactDetailModel?) {
        
        if (contactDetail != nil) {
            self.isEditing = true
        }
        
        self.contactDetail = contactDetail
        
        if contactDetail == nil {
            self.contactDetail = ContactDetailModel()
        }
        
        self.contactTableArray.removeAll()
        
        self.contactTableArray.append(ContactDetail(placeHolder: "First Name", description: self.contactDetail.first_name ?? ""))
        self.contactTableArray.append(ContactDetail(placeHolder: "Last Name", description: self.contactDetail.last_name ?? ""))
        self.contactTableArray.append(ContactDetail(placeHolder: "Mobile", description: self.contactDetail.phone_number ?? ""))
        self.contactTableArray.append(ContactDetail(placeHolder: "Email", description: self.contactDetail.email ?? ""))
        
        DispatchQueue.main.async {
            self.editContactTableView.dataSource = self
            self.editContactTableView.delegate = self
            self.editContactTableView.reloadData()
        }
    }
    
    func updateContactProfile(filePath:String?) {
        self.contactDetail.profile_pic = filePath
        DispatchQueue.main.async {
            self.editContactTableView.reloadData()
        }
    }
}

//MARK: TableView Delegates, DataSource
extension EditContactView:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0  {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EditContactImageTableViewCell
            cell.delegate = self
            cell.updateCellData(contact: self.contactDetail)
            cell.selectionStyle = .none
            return cell
        }
        
        let contactDesc = contactTableArray[indexPath.row-1]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactDescriptionTableViewCell
        cell.delegate = self
        cell.updateCellData(contact: self.contactDetail, contactDescription: contactDesc, isEditable: true)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactTableArray.count+1
    }
}


extension EditContactView:EditContactImageTableViewCellDelegate {
    func editContactImageTableViewCell(didSelectEdit cell: EditContactImageTableViewCell) {
        delegate?.editContactView(selectLibraryImage: self)
    }
}

extension EditContactView: ContactDescriptionCellDelegate {
    func contactDescriptionTableViewCell(_ cell: ContactDescriptionTableViewCell, didUpdateContactDescription contactDetail:ContactDetail) {
        
        let indexPath = self.editContactTableView.indexPath(for: cell)!
        contactTableArray[indexPath.row-1] = contactDetail
        
        for (i,contact) in contactTableArray.enumerated() {
            switch i {
            case 0:
                self.contactDetail.first_name = contact.description
                break
            case 1:
                self.contactDetail.last_name = contact.description
                break
            case 2:
                self.contactDetail.phone_number = contact.description
                break
            default:
                self.contactDetail.email = contact.description
                break
            }
        }
    }
}
