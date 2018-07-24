//
//  NotesController.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import UIKit

class NotesController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let notesRepository = NotesRepository()
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure everything UI related
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch notes to populate table view
        fetchNotes()
    }
    
}

// MARK: PRIVATE

extension NotesController {
    
    fileprivate func configureUI() {
        // Configure table view
        tableView.register(NoteCell.self)
        tableView.dataSource = self
    }
    
    fileprivate func fetchNotes() {
        // Request notes from repository
        notesRepository.fetchDummyNotes { [weak self] _ in
            print()
            // Operation finished. Reload data.
            self?.tableView.reloadData()
        }
    }
    
}

extension NotesController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesRepository.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteCell = tableView.dequeueReusableCell(for: indexPath)
        let note = notesRepository.item(at: indexPath.row)
        
        cell.populate(with: note)
        
        return cell
    }
    
}
