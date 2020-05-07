//
//  ViewController.swift
//  Top Five
//
//  Created by Sharence Solomero on 5/4/20.
//  Copyright © 2020 Sharence Solomero. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class OverviewViewController: UITableViewController, SwipeTableViewCellDelegate {

    let realm = try! Realm()
    
    //let listArray = ["Brunch Resturaunts", "NBA Players", "Movies of 2020"]
    //var topFiveListTitles = [TopFiveList]
    var topFiveListTitles: Results<TopFiveList>?

    //@IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register Overview Cell
        
        loadLists()
        
        self.tableView.register(UINib(nibName: "OverviewCell", bundle: nil), forCellReuseIdentifier: "OverviewCell")
        
        self.tableView.rowHeight = 90
        
        searchBar.delegate = self
        
    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return topFiveListTitles?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as! OverviewCell
        
        cell.delegate = self
        
        cell.listLabel.text = topFiveListTitles?[indexPath.row].listTitle ?? "No list yet"
        
        return cell
        
    }
    
    //MARK: - DATA MANIPULATION METHODS
    
    func saveItems(title: TopFiveList) {
        do {
            try realm.write {
                realm.add(title)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadLists() {

        topFiveListTitles = realm.objects(TopFiveList.self)
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add New List
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textInput = UITextField()
        
        let alert = UIAlertController(title: "Add New Top 5 List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Create", style: .default) { (action) in
            if textInput.text != "" {
                print("Item Added")
                
                let newList = TopFiveList()
                newList.listTitle = textInput.text!
                
                self.saveItems(title: newList)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Brunch Places in ATL..."
            textInput = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ItemsViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let title = topFiveListTitles?[indexPath.row].listTitle.uppercased()
            destinationVC.navigationItem.title = title
            destinationVC.selectedList = topFiveListTitles?[indexPath.row]
   
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
            self.updateModel(at: indexPath)
            tableView.reloadData()
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete_icon")

        return [deleteAction]
    }
    func updateModel(at indexPath: IndexPath) {
        if let list = self.topFiveListTitles?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(list)
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
    }


}

//MARK: - Search Bar Methods
extension OverviewViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        topFiveListTitles = topFiveListTitles?.filter("listTitle CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "listTitle", ascending: true)
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadLists()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}

