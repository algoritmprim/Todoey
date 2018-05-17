//
//  ViewController.swift
//  Todoey
//
//  Created by Vadim Gojan on 5/6/18.
//  Copyright © 2018 Vadim Gojan. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController{
    
    // 1. Creem Un itemArray
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    // 21. creem cale spre mapa cu documente
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 21. creem cale spre mapa cu documente
        
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
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
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
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
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
        
        do {
            try context.save()
        } catch {
            print("Eroor saving context, \(error)")
        }
        
        
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let aditionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, aditionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
 
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from the context \(error)")
            
        }
        
    }
    
   
    
}

//MARK: - Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
       
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

