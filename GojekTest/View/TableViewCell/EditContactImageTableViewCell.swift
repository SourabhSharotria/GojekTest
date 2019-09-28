//
//  EditContactImageTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class EditContactImageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(contact:ContactDetailModel) {
        self.avatarImageView.imageFromServerURL(urlString: contact.profile_pic ?? "")
    }
    
}
