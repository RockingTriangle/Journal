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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Properties
    var journal: Journal?
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        guard let entry = journal?.entries[indexPath.row] else { return cell }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d @ h:mm a"
        let date = dateFormatter.string(from: entry.entryCreationTimestamp)
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = "\(date)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.delete(journal: journal, entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? EntryDetailViewController, let journal = journal else { return }
        destinationVC.journal = journal
        
        if segue.identifier == "toEntryDetailVC" {
            guard let index = tableView.indexPathForSelectedRow else { return }
                let entry = journal.entries[index.row]
                destinationVC.entry = entry
        }
    }
}
