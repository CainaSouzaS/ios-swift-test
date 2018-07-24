//
//  NotesRepository.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import Foundation

class NotesRepository: DataSource {
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
}
