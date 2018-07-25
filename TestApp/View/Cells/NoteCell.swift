//
//  NoteCell.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadowView.layer.shadowRadius = 8
        shadowView.layer.cornerRadius = 8
    }
    
    /**
     * Populates the cell with contents of a Note object.
     *
     * - parameter note: A Note object to populate the cell with.
     */
    public func populate(with note: Note) {
        noteLabel.text = note.content
        dateLabel.text = note.formattedDate
    }
    
}
