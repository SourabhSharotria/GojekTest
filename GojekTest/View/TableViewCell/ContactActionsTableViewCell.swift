//
//  ContactActionsTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

protocol ContactActionsTableViewCellDelegate : class{
    
    func didSelectMessage(_ cell : ContactActionsTableViewCell)
    func didSelectCall(_ cell: ContactActionsTableViewCell)
    func didSelectEmail(_ cell: ContactActionsTableViewCell)
    func contactActionsTableViewCell(_ cell: ContactActionsTableViewCell, didSelectFavourite val: Bool)
}

class ContactActionsTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBgView: UIView!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var callBgView: UIView!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var emailBgView: UIView!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var favBgView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate:ContactActionsTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func messageAction(_ sender: Any) {
        delegate?.didSelectMessage(self)
    }
    
    @IBAction func callAction(_ sender: Any) {
        delegate?.didSelectCall(self)
    }
    
    @IBAction func emailAction(_ sender: Any) {
        delegate?.didSelectEmail(self)
    }
    
    @IBAction func favouriteAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.contactActionsTableViewCell(self, didSelectFavourite: sender.isSelected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(contact:ContactDetailModel) {
        self.favouriteButton.isSelected = contact.favorite ?? false
    }
    
}
