//
//  NotesRepository.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import Foundation

class NotesRepository: DataSource {
    static let shared = NotesRepository()
    
    // All notes available
    lazy var items: [NoteModel] = []
    
    // Keeps a copy of original items array whenever a search is started
    private var unfilteredItems: [NoteModel] = []
    
    // Private variables
    private let notesService = NotesService()
    
    /**
     * Fetches dummy notes asynchronously.
     *
     * - parameter completion: A closure indicating the completion of the operation
     */
    public func fetchDummyNotes(_ completion: @escaping () -> Void) {
        // Generate a list of dummy notes
        items = notesService.generateDummyNotes()
        
        // Keep a copy of original values for filtering purposes
        unfilteredItems = items
        
        // Operation finished. Indicate its completion to the closure.
        completion()
    }
    
    /**
     * Fetches notes asynchronously.
     *
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func fetchNotes(_ completion: @escaping () -> Void) {
        // TODO Retrieve list of notes
        
        // Operation finished. Indicate its completion to the closure.
        completion()
    }
    
    /**
     * Creates a new note asynchronously.
     *
     * - parameter content: The string content of the note.
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func saveNote(content: String, _ completion: @escaping () -> Void) {
        let note = NoteModel(note: content, createdAt: Date())
        
        items.append(note)
        items.sort { $0.createdAt > $1.createdAt}
        
        // Keep a copy of original values for filtering purposes
        unfilteredItems = items
        
        // Operation finished. Indicate its completion to the closure.
        completion()
    }
    
    /**
     * Filter the items containing some text.
     *
     * - parameter term: The search term to filter the items with.
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func search(_ term: String, _ completion: @escaping () -> Void) {
        guard term.count > 0 else {
            // Restore original values
            items = unfilteredItems
            
            // Call closure to indicate that operation has finished
            completion()
            return
        }
        
        // Filter items that contain the string searched
        items = unfilteredItems.filter { $0.note.localizedCaseInsensitiveContains(term) }
        
        // Call closure to indicate that operation has finished
        completion()
    }
    
}
