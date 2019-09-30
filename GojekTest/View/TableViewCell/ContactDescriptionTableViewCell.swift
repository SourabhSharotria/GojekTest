//
//  ContactDescriptionTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

protocol ContactDescriptionCellDelegate:class {
    func contactDescriptionTableViewCell(_ cell: ContactDescriptionTableViewCell, didUpdateContactDescription contactDetail:ContactDetail)
}

class ContactDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    weak var delegate:ContactDescriptionCellDelegate?
    var contactDetail:ContactDetail!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.descriptionTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(contact:ContactDetailModel, contactDescription:ContactDetail, isEditable:Bool? = false) {
        self.contactDetail = contactDescription
        self.headerLabel.text = contactDescription.placeHolder
        self.descriptionTextField.text = contactDescription.description
        self.descriptionTextField.isUserInteractionEnabled = isEditable!
    }
    
}
extension ContactDescriptionTableViewCell:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.contactDetail.description = updatedText
           delegate?.contactDescriptionTableViewCell(self, didUpdateContactDescription: self.contactDetail)
        }
        return true
    }
}
