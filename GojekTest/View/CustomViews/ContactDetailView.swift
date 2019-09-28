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
    func contactDetailView(_ view: ContactDetailView, didSelectContact contact:ContactsModel)
}

class ContactDetailView: UIView {
    @IBOutlet weak var contactDetailTableView: UITableView!
    var contactDetail:ContactDetailModel!
    var contactTableArray = [ContactDetail]()
    weak var delegate:ContactDetailViewDelegate?
    
    override func awakeFromNib() {
        self.configTableView()
    }
    
    private func configTableView() {
        
        self.contactDetailTableView.estimatedRowHeight = 300.0
        self.contactDetailTableView.rowHeight = UITableView.automaticDimension
        self.contactDetailTableView.sectionIndexColor = .gray
        
        self.contactDetailTableView.registerCell(ContactImageTableViewCell.self)
        self.contactDetailTableView.registerCell(ContactDescriptionTableViewCell.self)
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
            
            let contactDesc = contactTableArray[indexPath.row-1]
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactDescriptionTableViewCell
            cell.updateCellData(contact: self.contactDetail, contactDescription: contactDesc)
            cell.selectionStyle = .none
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.contactTableArray.count+1
        }
    }
