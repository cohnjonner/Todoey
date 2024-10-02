//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //instantiate three new item objects


        let newItem = Item()
        let newItem2 = Item()
        let newItem3 = Item()
        //label the item objects (note: it would make more sense and cut out a step if i just hand an initializer in my item class)
        
        newItem.title = "Follow The White Rabbit"
        newItem2.title = "Bend Spoon With Mind"
        newItem3.title = "Take The Red Pill"
        
        //adding items to item array
        
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
      

        
        /* if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }*/
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
       
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].isCompleted == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    //delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print (itemArray[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if itemArray[indexPath.row].isCompleted == false{
            itemArray[indexPath.row].isCompleted = true
        } else {
            itemArray[indexPath.row].isCompleted = false
        }
        
        if tableView.cellForRow(at:indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
//MARK - Add New Items section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var taskMaster = UITextField()
        
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add Task", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.title = taskMaster.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Enter Task"
            taskMaster = alertTextField
                        
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

