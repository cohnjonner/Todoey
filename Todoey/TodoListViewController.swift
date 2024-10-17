//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //instantiate three new item objects
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        //loadItems()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        //   let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isCompleted == true ? .checkmark: .none
        
        return cell
    }
    
    //delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print (itemArray[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        itemArray[indexPath.row].isCompleted = !itemArray[indexPath.row].isCompleted
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items section
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var taskMaster = UITextField()
        
        let alert = UIAlertController(title: "What needs to be tadone?", message: "", preferredStyle:.alert)
        let action = UIAlertAction(title: "Add Task", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = taskMaster.text!
            newItem.isCompleted = false
            
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
        alert.addAction(action)
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Enter Task"
            taskMaster = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        

        do{
           
            try context.save()
        }catch {
            print("error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    /*func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Some Error happened \(error)")
            }
            
            
            
        }
    }*/
    
    
}


