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
    func contactListView(addContact view: ContactListView)
    func contactListView(refreshContacts view: ContactListView)
}

class ContactListView: UIView {

    var sectionDetail = [Section]()
    @IBOutlet weak var contactListTableView: UITableView!
    weak var delegate:ContactListViewDelegate?
    
    var refreshControl = UIRefreshControl()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
     
    override func awakeFromNib() {
        self.configNavBarButton()
        self.configTableView()
    }
    
    private func configTableView() {
        
        self.contactListTableView.backgroundColor = #colorLiteral(red: 0.9489166141, green: 0.9490789771, blue: 0.9489063621, alpha: 1)
        self.contactListTableView.estimatedRowHeight = 80.0
        self.contactListTableView.rowHeight = UITableView.automaticDimension
        self.contactListTableView.sectionIndexColor = .gray
        
        self.contactListTableView.registerCell(ContactListTableViewCell.self)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.contactListTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh() {
        
        self.delegate?.contactListView(refreshContacts: self)
    }
    
    private func configNavBarButton() {
        self.getViewController()!.navigationItem.rightBarButtonItem = nil
        let backButton = UIBarButtonItem(image: nil, style: .plain, target: self, action:#selector(addContactAction))
        backButton.title = "Add"
        self.getViewController()!.navigationItem.rightBarButtonItem = backButton
    }
    
    @objc private func addContactAction(){
        delegate?.contactListView(addContact: self)
    }
    
    func updateSections(contacts:[ContactsModel]?) {
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        
        guard contacts != nil else {
            return
        }
        
        let groupedDictionary = Dictionary(grouping: (contacts!.map({$0})), by: {String(($0.first_name?.uppercased().prefix(1))!)})
                
        let keys = groupedDictionary.keys.sorted()
//        sectionDetail.removeAll()
        
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
        
        let headerView = UIView.init(frame: CGRect(x: 0, y: -20, width: tableView.bounds.size.width, height: 40))
        headerView.backgroundColor = #colorLiteral(red: 0.9489166141, green: 0.9490789771, blue: 0.9489063621, alpha: 1)
        
        let lblHeader = UILabel.init(frame: CGRect(x: 20, y: -20, width: tableView.bounds.size.width, height: 40))
        lblHeader.backgroundColor = #colorLiteral(red: 0.9489166141, green: 0.9490789771, blue: 0.9489063621, alpha: 1)
        lblHeader.text = "\(sectionDetail[section].letter)"
        lblHeader.font = UIFont.boldSystemFont(ofSize: 15)
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
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
