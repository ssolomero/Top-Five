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
    
    var selectedList: TopFiveList?
    
    private var itemNumber: Int = 0
    
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
        
        cell.textField.delegate = self
        
        let rowNumber = indexPath.row + 1
        let listName = selectedList?.listTitle
        cell.numberLabel.text = "\(rowNumber)."
        cell.textField.placeholder = "The #\(rowNumber) \(listName ?? "spot")"
    
        //cell.listLabel.text = topFiveListTitles?[indexPath.row].listTitle ?? "No list yet"
        
        //cell.listName.text = listArray[indexPath.row]
        
        return cell
        
    }
    
    //When item is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        cell.textField.isUserInteractionEnabled = true
        cell.textField.becomeFirstResponder()
        itemNumber = indexPath.row
        print(itemNumber)
    }
    
    
    func saveItems(item: ListItem) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        //tableView.reloadData()
    }
    
}

extension ItemsViewController: UITextFieldDelegate {
    
    //Exit keyboard and text field when Done(return) key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return false
    }
    
    //Save text input
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let currentList = self.selectedList {
            do {
                try self.realm.write {
                    if textField.text != "" {
                        let newItem = ListItem()
                        newItem.itemName = textField.text!
                        newItem.rank = itemNumber + 1
                        currentList.items.append(newItem)
                    }
                }
            } catch {
                print("Error saving context \(error)")
            }
        }
    }

}

