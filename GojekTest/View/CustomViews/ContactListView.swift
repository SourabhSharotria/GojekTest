//
//  ContactListView.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import UIKit

protocol ContactListViewDelegate:class {
    func contactListView(_ view: ContactListView, didSelectContact contact:ContactsModel)
}

class ContactListView: UIView {

    var sectionDetail = [Section]()
    @IBOutlet weak var contactListTableView: UITableView!
    weak var delegate:ContactListViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.configTableView()
    }
    
    private func configTableView() {
        
        self.contactListTableView.estimatedRowHeight = 300.0
        self.contactListTableView.rowHeight = UITableView.automaticDimension
        self.contactListTableView.sectionIndexColor = .gray
        
        self.contactListTableView.registerCell(ContactListTableViewCell.self)
    }
    
    func updateSections(contacts:[ContactsModel]?) {
        
        guard contacts != nil else {
            return
        }
        
        let groupedDictionary = Dictionary(grouping: (contacts!.map({$0})), by: {String(($0.first_name?.uppercased().prefix(1))!)})
                
        let keys = groupedDictionary.keys.sorted()
        sectionDetail.removeAll()
        
        sectionDetail = keys.map({Section(letter: $0, contacts: groupedDictionary[$0]!)})
        
        DispatchQueue.main.async {
            self.contactListTableView.dataSource = self
            self.contactListTableView.delegate = self
            self.contactListTableView.reloadData()
        }
    }
}

//MARK: TableView Delegates, DataSource

extension ContactListView:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print("\(indexPath.section) \(indexPath.row)")
        let contactDetail = sectionDetail[indexPath.section].contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ContactListTableViewCell
        cell.updateCellData(contact: contactDetail)
        cell.selectionStyle = .none
        return cell
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetail = sectionDetail[indexPath.section].contacts[indexPath.row]
        delegate?.contactListView(self, didSelectContact: contactDetail)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionDetail[section].contacts.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDetail.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let lblHeader = UILabel.init(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        
        lblHeader.text = "\(sectionDetail[section].letter)"
        lblHeader.font = UIFont.systemFont(ofSize: 15)
        lblHeader.textColor = .black
        headerView.addSubview(lblHeader)
        return headerView
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionDetail.map{$0.letter}
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionDetail[section].letter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
