//
//  NotesService.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import Foundation

class NotesService {
    
    /**
     * Generates a list of dummy notes.
     *
     * - returns: An array of NoteModel objects.
     */
    public func generateDummyNotes() -> [NoteModel] {
        let note = NoteModel(note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque at porttitor nibh. In nec metus et orci rhoncus congue. Praesent augue eros, eleifend in lobortis in, convallis sed nibh.", createdAt: Date())
        
        return Array(repeating: note, count: 10)
    }
    
}
