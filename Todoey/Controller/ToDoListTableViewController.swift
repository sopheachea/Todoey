//
//  ToDoListTableViewController.swift
//  Todoey
//
//  Created by sophea chea on 5/12/20.
//

import UIKit
import RealmSwift


class ToDoListTableViewController: UITableViewController {

    var todoItems: Results<Items>?
    let realm =  try! Realm()
    
    var selectedCategory: Categories? {
        didSet{
            loadItem()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        loadItem()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoItems?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            // Ternary Operator ==>
            // value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No item added"
        }
            
        return cell
    }
 
    // MARK: - Table view deligate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = todoItems?[indexPath.row]{
            do {
                try realm.write(){
                    item.done = !item.done
                }
            }catch {
                print("Error saving done status, \(error)")
            }
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
            
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write(){
                        let newItem = Items()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Model Manupulation Methods

    // Create data
 
    // Read data
    func loadItem(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

//MARK: Search bar methods

extension ToDoListTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
