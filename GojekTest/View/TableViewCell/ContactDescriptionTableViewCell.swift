//
//  ContactDescriptionTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class ContactDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(contact:ContactDetailModel, contactDescription:ContactDetail) {
        self.headerLabel.text = contactDescription.placeHolder
        self.descriptionLabel.text = contactDescription.description
    }
    
}
