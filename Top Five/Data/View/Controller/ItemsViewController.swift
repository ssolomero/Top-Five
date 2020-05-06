//
//  ItemsViewController.swift
//  Top Five
//
//  Created by Sharence Solomero on 5/5/20.
//  Copyright © 2020 Sharence Solomero. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //navigationItem.title = "Hello"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Righteous-Regular", size: 20)!]
        
    }
}
