//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Mike Conner on 4/19/21.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
  
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Properties
    var entry: Entry?
    var journal: Journal?
    
    //MARK: - IBActions
    @IBAction func saveButtonWasTapped(_ sender: Any) {
        guard let journal = journal, let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else { return }
        if let entry = entry {
            EntryController.update(entry: entry, with: title, and: body)
        } else {
            EntryController.createEntryWith(journal: journal, title: title, and: body)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonWasTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
}
