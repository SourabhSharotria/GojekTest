//
//  EditContactView.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

protocol EditContactViewDelegate:class {
    func editContactView(_ view: EditContactView, addContact contact:ContactsModel)
    func editContactView(_ view: EditContactView, updateContact contact:ContactsModel)
}

class EditContactView: UIView {

    @IBOutlet weak var editContactTableView: UITableView!
    weak var delegate:EditContactViewDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
