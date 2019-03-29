//
//  ViewController.swift
//  Todoey
//
//  Created by Krithiga Hari on 3/26/19.
//  Copyright © 2019 Krithiga Hari. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Apples", "Oranges", "Grapes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK  - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    //MARK - Table View Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print (itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
    }
    
    // MARK - Add New items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // What will happen once the user clicks on the add item button
           // print("success!")
            // Adding new item to the array
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
            
        }
        //adding a text field in the alert
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        //Add action to the alert
        alert.addAction(action)
        
        //Show the alert
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

