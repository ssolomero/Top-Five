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

    private var listItems: Results<ListItem>?

    private let realm = try! Realm()
    
    var selectedList: TopFiveList? {
        didSet {
            loadItems()
        }
    }
    
   
    private var itemNumber: Int = 0 //Tracks number (1. - 5.) the user selected

    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.tableView.register(UINib(nibName: "ListItemCell", bundle: nil), forCellReuseIdentifier: "ListItemCell")
        
        tableView.rowHeight = 70
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! ListItemCell
        
        cell.textField.delegate = self
        
        let rowNumber = indexPath.row + 1
        cell.numberLabel.text = "\(rowNumber)."
        switch rowNumber {
            
        case 1: cell.textField.placeholder = "First Place"
        case 2: cell.textField.placeholder = "First Place Loser"
        case 3: cell.textField.placeholder = "Bronze"
        case 4: cell.textField.placeholder = "So-so"
        case 5: cell.textField.placeholder = "Last but not least"
        default: cell.textField.placeholder = "The number \(rowNumber) spot"
        
        }
        
        //Retreive item name from realm database and add to view
        let count: Int = listItems?.count ?? 0
        if count > 0 {
            for place in 0...count - 1 {
                if listItems?[place].rank == indexPath.row {
                    cell.textField.text = listItems?[place].itemName
                    break
                }
            }
        }
        
        return cell
    }
    
    //MARK: - DATA MANIPULATION METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        cell.textField.isUserInteractionEnabled = true
        cell.textField.becomeFirstResponder()
        itemNumber = indexPath.row
    }
    
    func loadItems() {
        
        listItems = selectedList?.items.sorted(byKeyPath: "rank", ascending: true)
        tableView.reloadData()
    }
    
    func updateData(_ textField: UITextField) {
        
        if let currentList = self.selectedList {
            do {
                try self.realm.write {
                    if textField.text != "" {
                        //Delete any items that has the same rank
                        let prevItem = currentList.items.filter("rank == %@", itemNumber)
                        realm.delete(prevItem)
                        //Add new item
                        let newItem = ListItem()
                        newItem.itemName = textField.text!
                        newItem.rank = itemNumber
                        currentList.items.append(newItem)
                    }
                }
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
    
    
}

//MARK: - TEXT FIELD DELEGATE

extension ItemsViewController: UITextFieldDelegate {
    
    //Exit keyboard and text field when Done(return) key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return false
    }
    
    //Save text input
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateData(textField)
    }

}

