//
//  ContactDetailView.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

struct ContactCellDetail {
    let placeholder : String
    let description : String
}

protocol ContactDetailViewDelegate:class {
    func contactDetailView(_ view: ContactDetailView, editContact contact:ContactDetailModel)
    
    func contactDetailView(_ view: ContactDetailView, didSelectCall phoneNumber:String)
    func contactDetailView(_ view: ContactDetailView, didSelectMessage phoneNumber:String)
    func contactDetailView(_ view: ContactDetailView, didSelectEmail email:String)
    func contactDetailView(_ view: ContactDetailView, didSelectFavourite contact: ContactDetailModel)
}

class ContactDetailView: UIView {
    @IBOutlet weak var contactDetailTableView: UITableView!
    var contactDetail:ContactDetailModel!
    var contactTableArray = [ContactDetail]()
    weak var delegate:ContactDetailViewDelegate?
    
    override func awakeFromNib() {
        self.configNavBarButton()
        self.configTableView()
    }
    
    private func configNavBarButton() {
        self.getViewController()!.navigationItem.rightBarButtonItem = nil
        let backButton = UIBarButtonItem(image: nil, style: .plain, target: self, action:#selector(editContactAction))
        backButton.title = "Edit"
        self.getViewController()!.navigationItem.rightBarButtonItem = backButton
    }
    
    private func configTableView() {
        
        self.contactDetailTableView.estimatedRowHeight = 80.0
        self.contactDetailTableView.rowHeight = UITableView.automaticDimension
        self.contactDetailTableView.sectionIndexColor = .gray
        
        self.contactDetailTableView.registerCell(ContactImageTableViewCell.self)
        self.contactDetailTableView.registerCell(ContactActionsTableViewCell.self)
        self.contactDetailTableView.registerCell(ContactDescriptionTableViewCell.self)
    }
    
    @objc private func editContactAction(){
        
        delegate?.contactDetailView(self, editContact: self.contactDetail)
    }
    
    func updateContactDetail(contactDetail:ContactDetailModel) {
        self.contactDetail = contactDetail
        
        self.contactTableArray.removeAll()
        self.contactTableArray.append(ContactDetail(placeHolder: "mobile", description: self.contactDetail.phone_number ?? ""))
        self.contactTableArray.append(ContactDetail(placeHolder: "email", description: self.contactDetail.email ?? ""))
        
        DispatchQueue.main.async {
            self.contactDetailTableView.dataSource = self
            self.contactDetailTableView.delegate = self
            self.contactDetailTableView.reloadData()
        }
    }
}

//MARK: TableView Delegates, DataSource
extension ContactDetailView:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0  {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactImageTableViewCell
            cell.updateCellData(contact: self.contactDetail)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1  {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactActionsTableViewCell
            cell.updateCellData(contact: self.contactDetail)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        let contactDesc = contactTableArray[indexPath.row-2]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactDescriptionTableViewCell
        cell.updateCellData(contact: self.contactDetail, contactDescription: contactDesc)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactTableArray.count+2
    }
}

extension ContactDetailView:ContactActionsTableViewCellDelegate {
    func didSelectMessage(_ cell: ContactActionsTableViewCell) {
        delegate?.contactDetailView(self, didSelectMessage: self.contactDetail.phone_number ?? "")
    }
    
    func didSelectCall(_ cell: ContactActionsTableViewCell) {
        delegate?.contactDetailView(self, didSelectCall: self.contactDetail.phone_number ?? "")
    }
    
    func didSelectEmail(_ cell: ContactActionsTableViewCell) {
        delegate?.contactDetailView(self, didSelectEmail: self.contactDetail.email ?? "")
    }
    
    func contactActionsTableViewCell(_ cell: ContactActionsTableViewCell, didSelectFavourite val: Bool) {
        
        self.contactDetail.favorite = val
        delegate?.contactDetailView(self, didSelectFavourite: self.contactDetail)
    }
    
    
}
