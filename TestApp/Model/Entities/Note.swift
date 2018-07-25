//
//  Note.swift
//  
//
//  Created by Cainã Souza on 2018-07-24.
//
//

import Foundation
import CoreData

extension Note {
    
    // User friendly date format
    var formattedDate: String {
        guard createdAt != nil else { return "" }
        
        // FIXME Formatter should be somewhere else
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        
        return formatter.string(from: createdAt! as Date)
    }
    
}
