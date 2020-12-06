//
//  ToDoListTableViewController.swift
//  Todoey
//
//  Created by sophea chea on 5/12/20.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var itemArray = [Items]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemArray.append(Items(title: "Find Milk"))
        itemArray.append(Items(title: "Buy Eggos"))
        itemArray.append(Items(title: "Destroy Demogorgon"))
        
        if let item = userDefaults.array(forKey: "ToDoListArray") as? [Items]{
            itemArray = item
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let item = itemArray[indexPath.row]
        
        // Configure the cell...
        
        cell.textLabel?.text = item.title
        
        // Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none     // this line is equal to if statement below
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
 
    // MARK: - Table view deligate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
           
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done  // this line is equal to the if statement above
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Add New Items
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks Add Item button on our UIAlert
            
            let newItem = Items()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.userDefaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
//            print(alertTextField.text)
//            print("now")
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}