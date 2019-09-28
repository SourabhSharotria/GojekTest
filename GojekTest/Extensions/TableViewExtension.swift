//
//  TableViewExtension.swift
//  GojekTest
//
//  Created by Sourav on 28/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<Cell:UITableViewCell>(_ cellClass: Cell.Type) {
        register(UINib(nibName:String(describing: cellClass), bundle: nil), forCellReuseIdentifier: String(describing: cellClass))
    }
    func dequeueReusableCell<Cell:UITableViewCell>(forIndexPath indexPath:IndexPath) -> Cell {
        let idenitifier = String(describing: Cell.self)
        guard let genCell = dequeueReusableCell(withIdentifier:idenitifier , for: indexPath) as? Cell else {
            fatalError("No cell found for indexPath: \(indexPath) forIdentifier: \(idenitifier)")
        }
        return genCell
    }
}
