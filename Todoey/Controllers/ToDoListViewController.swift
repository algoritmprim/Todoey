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
    
    var itemArray = [Item]()
    
    // 21. creem cale spre mapa cu documente
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 21. creem cale spre mapa cu documente
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
        print(dataFilePath)
        
        loadItems()
        
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
        
        // 19. cream o constanata pentru a simplifica codul
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //20. cream operatorul ternar
        // value = condition ? valueIfTrue : valueIFFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate methods
    // 4. functie c/r de selectarea celulelor
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        
        // 17.setam ca checkmarkul sa fie diferit de cel ce este
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        
        
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
            
            // 16. cream un nou obiect de clasa Item
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItem()
            
        }
        // 9. creem un cimp de text pentru alerta creata mai sus, si luam variabila creata la punctul 10 pentru ai da valoarea textului din alertTextFielf
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItem(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch {
            print("Error enconding item array, \(error)")
            
        }
        
        // 11. metoda c/r de reincarcarea datelor in tableView
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding itemArray, \(error)")
            }
        }
        
    }

}

