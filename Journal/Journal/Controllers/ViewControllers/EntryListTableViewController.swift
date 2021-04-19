//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Mike Conner on 4/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.sharedInstance.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedInstance.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.sharedInstance.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.sharedInstance.entries[indexPath.row]
            EntryController.sharedInstance.delete(entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetailVC" {
            if let index = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
                let data = EntryController.sharedInstance.entries[index.row]
                destinationVC.entry = data
            }
        }
    }
}
