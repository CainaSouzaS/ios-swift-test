//
//  NotesRepository.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import Foundation
import CoreData

class NotesRepository: DataSource {
    static let shared = NotesRepository()
    
    // All notes available
    lazy var items: [Note] = []
    
    // Keeps a copy of original items array whenever a search is started
    private var unfilteredItems: [Note] = []
    
    // Core Data context
    private(set) var context: NSManagedObjectContext?
    
    /**
     * Configures this repository with the context used to persist objects.
     *
     * - parameter context: A NSManagedObjectContext object used by the application to manage local storage.
     */
    public func configure(with context: NSManagedObjectContext) {
        self.context = context
    }
    
    /**
     * Fetches dummy notes asynchronously.
     *
     * - parameter completion: A closure indicating the completion of the operation
     */
//    public func fetchDummyNotes(_ completion: @escaping () -> Void) {
//        // Generate a list of dummy notes
//        items = notesService.generateDummyNotes()
//        
//        // Keep a copy of original values for filtering purposes
//        unfilteredItems = items
//        
//        // Operation finished. Indicate its completion to the closure.
//        completion()
//    }
    
    /**
     * Fetches notes asynchronously.
     *
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func fetchNotes(_ completion: @escaping (Error?) -> Void) {
        guard let context = self.context else {
            // FIXME Should return an error instead
            completion(nil)
            return
        }
        
        let notesFetchRequest = NSFetchRequest<Note>(entityName: String(describing: Note.classForCoder()))
        // FIXME Get the key from somewhere else
        notesFetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            items = try context.fetch(notesFetchRequest)
            
            // Keep a copy of original values for filtering purposes
            unfilteredItems = items
            
            // Operation finished. Indicate its completion to the closure.
            completion(nil)
        } catch {
            // Operation failed. Indicate its completion to the closure.
            completion(error)
        }
        
    }
    
    /**
     * Creates a new note.
     *
     * - parameter content: The string content of the note.
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func saveNote(content: String, _ completion: @escaping (Error?) -> Void) {
        guard let context = self.context else {
            // FIXME Should return an error instead
            completion(nil)
            return
        }
        
        let note = Note(context: context)
        note.content = content
        note.createdAt = NSDate()
        
        do {
            try context.save()
            
            // Operation finished. Indicate its completion to the closure.
            completion(nil)
        } catch {
            // Operation failed. Indicate its completion to the closure.
            completion(error)
        }
    }
    
    /**
     * Updates a note.
     *
     * - parameter note: The Note to be updated.
     * - parameter content: The String content of the note.
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func update(note: Note, content: String, _ completion: @escaping (Error?) -> Void) {
        guard let context = self.context else {
            // FIXME Should return an error instead
            completion(nil)
            return
        }
        
        // Update its content
        note.content = content
        
        do {
            try context.save()
            
            // Operation finished. Indicate its completion to the closure.
            completion(nil)
        } catch {
            // Operation failed. Indicate its completion to the closure.
            completion(error)
        }
    }
    
    /**
     * Deletes a note.
     *
     * - parameter note: The Note to be deleted.
     * - parameter completion: A closure indicating the completion of the operation.
     */
    public func delete(note: Note, _ completion: @escaping (Error?) -> Void) {
        guard let context = self.context else {
            // FIXME Should return an error instead
            completion(nil)
            return
        }
        
        // Delete object
        context.delete(note)
        
        do {
            // Save context to actually perform deletion
            try context.save()
            
            // Operation finished. Indicate its completion to the closure.
            completion(nil)
        } catch {
            // Operation failed. Indicate its completion to the closure.
            completion(error)
        }
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
        items = unfilteredItems.filter { $0.content?.localizedCaseInsensitiveContains(term) ?? false }
        
        // Call closure to indicate that operation has finished
        completion()
    }
    
}
