//
//  ItemsViewController.swift
//  Top Five
//
//  Created by Sharence Solomero on 5/5/20.
//  Copyright © 2020 Sharence Solomero. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsViewController: UITableViewController {

    var listItems: Results<ListItem>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "ListItemCell", bundle: nil), forCellReuseIdentifier: "ListItemCell")
        
        tableView.rowHeight = 70
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! ListItemCell
        
        //cell.listLabel.text = topFiveListTitles?[indexPath.row].listTitle ?? "No list yet"
        
        //cell.listName.text = listArray[indexPath.row]
        
        return cell
        
    }
}
