//
//  ContactListTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(contact:ContactsModel) {
        self.avatarImageView.imageFromServerURL(urlString: contact.profile_pic ?? "")
        self.nameLabel.text = "\(contact.first_name ?? "") \(contact.last_name ?? "")"
        self.favouriteButton.isSelected = contact.favorite ?? false
    }
}
