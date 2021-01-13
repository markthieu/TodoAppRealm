//
//  CategoryViewController.swift
//  todoApp
//
//  Created by Marmago on 30/11/2020.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        loadCategories()
        
        tableView.separatorStyle = .none

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let navBar =  navigationController?.navigationBar else{
            fatalError("Navigation controller does not exist")}
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }
    //MARK: - Add Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Local UITextField available for the full scope of the funciton
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
           
            let newCategory = Category( )
            newCategory.name = textField.text!
            newCategory.color = RandomFlatColor().hexValue()
            
            
            self.saveCategories(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    //MARK: - Data Manipulation Methods
    func saveCategories(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving context: \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    //Override super method from SwipeTableView Controller to delete
    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = categories?[indexPath.row]{
            do {
                try self.realm.write{
                    self.realm.delete(categoryToDelete)
                }
            } catch  {
                print("Error updating realm: \(error)")
            }
        }
    }
    //MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row]{
            cell.textLabel?.text = category.name
            guard let categoryColor = UIColor(hexString: category.color ) else{ fatalError("Color not found")}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.rootToItems, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

}
