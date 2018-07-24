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
    
    /**
     * Fetches dummy notes asynchronously.
     *
     * - parameter completion: A closure indicating the completion of the operation
     */
    public func fetchNotes(_ completion: @escaping () -> Void) {
        // Generate a list of dummy notes
        items = generateDummyNotes()
        
        // Operation finished. Indicate its completion to the closure.
        completion()
    }
}

// MARK: PRIVATE

extension NotesRepository {
    
    /**
     * Generates a list of dummy notes.
     *
     * - returns: An array of NoteModel objects.
     */
    fileprivate func generateDummyNotes() -> [NoteModel] {
        let note = NoteModel(note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque at porttitor nibh. In nec metus et orci rhoncus congue. Praesent augue eros, eleifend in lobortis in, convallis sed nibh.", createdAt: Date())
        
        return Array(repeating: note, count: 10)
    }
    
}
