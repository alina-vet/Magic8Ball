//
//  SettingTableViewController.swift
//  Magic8Ball
//
//  Created by Алина Бондарчук on 27.01.2022.
//

import UIKit


class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var addDataButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let message = answerModel[indexPath.row]
        cell.textLabel?.text = message
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeAnswer(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
    // MARK: - Action
    
    @IBAction func addDataAction(_ sender: Any) {
        
        let ac = UIAlertController(title: "Create your answer", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "New answer name"
        }
        ac.addAction(UIAlertAction(title: "Create", style: .default, handler: { (alert) in
            let newAnswer = ac.textFields![0].text
            addData(nameAnswer: newAnswer!)
            self.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }

    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            self.editButton.title = "Done"
        } else {
            self.editButton.title = "Edit"
        }
        
        tableView.reloadData()
    }
    
}
