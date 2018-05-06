//
//  ViewController.swift
//  Todoey
//
//  Created by Vadim Gojan on 5/6/18.
//  Copyright © 2018 Vadim Gojan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    // 1. Creem Un itemArray
    
    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - Tablewiew Datasource Methods
    
    // 2. creem metode pentru preluarea surselor de date
    // functie c/r de numarul de celule
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // 3. functie c/r de afisajul celulelor
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // cream o celula
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    //MARK: - TableView Delegate methods
    // 4. functie c/r de selectarea celulelor
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // 6. conditional ce raspunde de aparitia si disparitia checkmarkului
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        // 5 functie ce raspunde de deselctare celulelor
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARk: - Add new items
    // 7. Creem butonul de audaugare- addButtonpresed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // 10. Creem o variabila locala
        
        var textField = UITextField()
        
        //8. creem o alerta
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // ce se va intimpla du pa ce utilizatorul va apasa butonul add item dun alerta
            
            self.itemArray.append(textField.text!)
            
        // 11. metoda c/r de reincarcarea datelor in tableView
      
            self.tableView.reloadData()
        
        }
        // 9. creem un cimp de text pentru alerta creata mai sus, si luam variabila creata la punctul 10 pentru ai da valoarea textului din alertTextFielf
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

