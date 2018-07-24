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
        
        // Operation finished. Indicate its completion to the closure.
        completion()
    }
    
}
