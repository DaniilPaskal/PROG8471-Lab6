//
//  TodoTableViewController.swift
//  Lab6
//
//  Created by user237236 on 2/12/24.
//

import UIKit

class TodoTableViewController: UITableViewController {
    var todos: [TodoItem]?
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        
        alert.addTextField{ (todoField) in
            todoField.placeholder = "Write an Item"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned alert] (action) -> Void in
            let todoField = alert.textFields![0] as UITextField
            
            let newTodo = TodoItem(context: self.content)
            newTodo.text = todoField.text
            
            do {
                try self.content.save()
            } catch {
                print("Error saving data")
            }
            
            self.fetchTodos()
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    func fetchTodos() {
        do {
            self.todos = try content.fetch(TodoItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("No todos found")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        fetchTodos()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        
        cell.todoLabel.text = self.todos?[indexPath.row].text

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoToRemove = self.todos![indexPath.row]
            self.content.delete(todoToRemove)
            
            do {
                try self.content.save()
            } catch {
                print("Error saving data")
            }
            
            self.todos?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
