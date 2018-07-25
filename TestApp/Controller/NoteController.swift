//
//  ViewController.swift
//  TestApp
//
//

import UIKit

protocol NoteControllerDelegate: class {
    func didFinishCreatingNote()
}

class NoteController: UIViewController {
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    weak var delegate: NoteControllerDelegate?
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure everything UI related
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if note == nil {
            // Present keyboard
            contentTextView.becomeFirstResponder()
        }
    }
    
}

// MARK: ACTIONS

extension NoteController {
    
    @IBAction func closeNote(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNote(sender: UIButton) {
        if note != nil {
            update(note: note!)
        } else {
            createNote()
        }
    }
    
    @IBAction func deleteNote(sender: UIButton) {
        guard note != nil else { return }
        
        confirm(title: "Confirmation", message: "Would you really like to delete this note?") {
            sender.isUserInteractionEnabled = false
            
            // Creates and save a new Note object
            NotesRepository.shared.delete(note: self.note!) { [weak self] error in
                sender.isUserInteractionEnabled = true
                
                guard error == nil else {
                    self?.alert(title: "Something went wrong", message: error?.localizedDescription ?? "Unable to delete note.")
                    return
                }
                
                self?.delegate?.didFinishCreatingNote()
                self?.closeNote(sender: self!.deleteButton)
            }
        }
    }
    
}

// MARK: PRIVATE

extension NoteController {
    
    /*
     * Configure all UI elements
     */
    fileprivate func configureUI() {
        // Configure action buttons
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        deleteButton.layer.cornerRadius = deleteButton.frame.width / 2
        
        // Configure text view
        contentTextView.layer.cornerRadius = 6
        contentTextView.textContainerInset = UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 10)
        
        // Populate UI with current Note, if any
        if note != nil {
            // Populate text view
            contentTextView.text = note!.content
            
            // Show save button
            saveButton.bounceIn()
            
            // Show delete button
            deleteButton.bounceIn()
        }
    }
    
    /*
     * Validates whether the text input is valid or not.
     *
     * - returns: A boolean value indicating whether the value input is valid or not.
     */
    fileprivate func validate() -> Bool {
        return !contentTextView
            .text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty
    }
    
    /**
     * Creates a new Note object.
     */
    fileprivate func createNote() {
        NotesRepository.shared.saveNote(content: contentTextView.text) { [weak self] error in
            guard error == nil else {
                self?.alert(title: "Something went wrong", message: error?.localizedDescription ?? "Unable to save note.")
                return
            }
            
            self?.delegate?.didFinishCreatingNote()
            self?.closeNote(sender: self!.saveButton)
        }
    }
    
    /**
     * Updates an existing note.
     *
     * - parameter note: The Note to be updated.
     */
    fileprivate func update(note: Note) {
        NotesRepository.shared.update(note: note, content: contentTextView.text) { [weak self] error in
            guard error == nil else {
                self?.alert(title: "Something went wrong", message: error?.localizedDescription ?? "Unable to save note.")
                return
            }
            
            self?.delegate?.didFinishCreatingNote()
            self?.closeNote(sender: self!.saveButton)
        }
    }
    
}

// MARK: UITextViewDelegate

extension NoteController: UITextViewDelegate {
    
    // Listen to text changes in order to present/hide save button
    internal func textViewDidChange(_ textView: UITextView) {
        if validate() {
            guard saveButton.isHidden else { return }
            saveButton.bounceIn()
        } else {
            guard !saveButton.isHidden else { return }
            saveButton.bounceOut()
        }
    }
    
}

