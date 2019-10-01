//
//  EditContactImageTableViewCell.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

protocol EditContactImageTableViewCellDelegate : class{
    func editContactImageTableViewCell(didSelectEdit cell: EditContactImageTableViewCell)
}

class EditContactImageTableViewCell: UITableViewCell {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    weak var delegate:EditContactImageTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gradientColor = #colorLiteral(red: 0.8638405204, green: 0.9655639529, blue: 0.9411936998, alpha: 1)
        let gradientColor1 = #colorLiteral(red: 0.9600678086, green: 0.9846132398, blue: 0.9763054252, alpha: 1)
        
        gradientView.layer.masksToBounds = true
        gradientView.applyGradient(colours: [gradientColor1, gradientColor], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 0.0, y: 1.0))
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editClicked(_ sender: Any) {
        delegate?.editContactImageTableViewCell(didSelectEdit: self)
    }
    
    func updateCellData(contact:ContactDetailModel) {
        
        guard contact.profile_pic != nil else {
            return
        }
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: contact.profile_pic ?? "") {
            self.avatarImageView.image = UIImage(contentsOfFile: contact.profile_pic!)
            return
        }
        self.avatarImageView.imageFromServerURL(contact.profile_pic ?? "", placeHolder: #imageLiteral(resourceName: "placeholder_photo"))
    }
    
}

