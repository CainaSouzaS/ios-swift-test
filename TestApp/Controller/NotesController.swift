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
    @IBOutlet weak var addButton: UIButton!
    
    fileprivate let transition = ACCircleTransition()
    
    // MARK: LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure everything UI related
        configureUI()
        
        // Populate with dummy data
        fetchDummyNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch notes to populate table view
        fetchNotes()
    }
    
}

// MARK: ACTIONS

extension NotesController {
    
    @IBAction func createNote(sender: UIButton) {
        // Create and present the controller to create/edit a note
        guard let noteController = controller(for: .note, from: .main) as? NoteController else { return }
        noteController.transitioningDelegate = self
        noteController.modalPresentationStyle = .custom
        noteController.delegate = self
        
        transition.startingPoint = sender.center
        transition.circleColor = sender.backgroundColor ?? .white
        
        present(noteController, animated: true, completion: nil)
    }
}

// MARK: PRIVATE

extension NotesController {
    
    /*
     * Configure all UI elements
     */
    fileprivate func configureUI() {
        // Configure table view
        tableView.register(NoteCell.self)
        tableView.dataSource = self
        
        // Configure add button
        addButton.layer.cornerRadius = addButton.frame.width / 2
    }
    
    /*
     * Retrieves a list of dummy notes.
     */
    fileprivate func fetchDummyNotes() {
        // Request notes from repository
        NotesRepository.shared.fetchDummyNotes { [weak self] _ in
            // Operation finished. Reload data.
            self?.tableView.reloadData()
        }
    }
    
    /*
     * Retrieves a list of notes from the repository and reload the table view.
     */
    fileprivate func fetchNotes() {
        // Request notes from repository
        NotesRepository.shared.fetchNotes { [weak self] _ in
            // Operation finished. Reload data.
            self?.tableView.reloadData()
        }
    }
    
    /**
     * Filters a list of NoteModel objects containing a certain term.
     *
     * - parameter text: The term used to filter the list of notes.
     */
    fileprivate func searchItems(with text: String) {
        NotesRepository.shared.search(text) { [weak self] _ in
            // Operation finished. Reload data.
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: UITableViewDataSource

extension NotesController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotesRepository.shared.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteCell = tableView.dequeueReusableCell(for: indexPath)
        let note = NotesRepository.shared.item(at: indexPath.row)
        
        cell.populate(with: note)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension NotesController: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
    
}

// MARK: NoteControllerDelegate

extension NotesController: NoteControllerDelegate {
    
    internal func didFinishCreatingNote() {
        // Reload list of notes
        fetchNotes()
    }
    
}

// MARK: UISearchBarDelegate

extension NotesController: UISearchBarDelegate {
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss keyboard
        searchBar.resignFirstResponder()
    }
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Process search request
        searchItems(with: searchText)
    }
    
}

// MARK: UIViewControllerTransitioningDelegate

extension NotesController: UIViewControllerTransitioningDelegate {
    
    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        
        return transition
    }
    
    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        
        return transition
    }
    
}
