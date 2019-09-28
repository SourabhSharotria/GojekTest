//
//  ContactActionsTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

class ContactActionsTableViewCell: UITableViewCell {

    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func messageAction(_ sender: Any) {
    }
    
    @IBAction func callAction(_ sender: Any) {
    }
    
    @IBAction func emailAction(_ sender: Any) {
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
