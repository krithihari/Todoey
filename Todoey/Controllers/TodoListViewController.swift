//
//  ViewController.swift
//  Todoey
//
//  Created by Krithiga Hari on 3/26/19.
//  Copyright © 2019 Krithiga Hari. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

   // let defaults = UserDefaults.standard
    
    var itemArray = [Item]()
    let dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
   // var itemArray = ["Apples", "Oranges", "Grapes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Creating a File path variable
        
      
        
        print (dataFilePath!)
        
        //Creating new item to add to new ItemArray array of item objects
        
        let newItem = Item()
        newItem.title = "Apples"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Oranges"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Grapes"
        itemArray.append(newItem3)
        
        loadItems()
        
    }

    //MARK  - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    //MARK - Table View Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print (itemArray[indexPath.row])
        
        //Sets itemArray's done property of the selected cell to the opposite of what it was before
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    // MARK - Add New items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // What will happen once the user clicks on the add item button
           // print("success!")
            // Adding new item to the array
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
            
        }
        
        
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error loading data, \(error)")
            }
            
        }
    }
    
}

