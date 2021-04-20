//
//  JournalListViewController.swift
//  Journal
//
//  Created by Mike Conner on 4/20/21.
//

import UIKit

class JournalListViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistenceStore()
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let journalTitle = journalTitleTextField.text, !journalTitle.isEmpty else { return }
        JournalController.shared.createJournalWith(title: journalTitle)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryList" {
            if let index = journalListTableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? EntryListTableViewController else { return }
                let journal = JournalController.shared.journals[index.row]
                destinationVC.journal = journal
            }
        }
        
    }
} //End of class

extension JournalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalListTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = journal.entries.count == 1 ?  "1 Entry" : "\(journal.entries.count) Entries"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journalToDelete = JournalController.shared.journals[indexPath.row]
            JournalController.shared.delete(journal: journalToDelete)
            journalListTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
} //End of extension
