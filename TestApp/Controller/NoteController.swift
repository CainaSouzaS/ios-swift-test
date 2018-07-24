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
    @IBOutlet weak var closeButton: UIButton!
    
    weak var delegate: NoteControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure everything UI related
        configureUI()
    }
    
}

// MARK: ACTIONS

extension NoteController {
    
    @IBAction func closeNote(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveNote(sender: UIButton) {
        sender.isUserInteractionEnabled = false
        
        // Creates and save a new NoteModel object
        NotesRepository.shared.saveNote(content: contentTextView.text) { [weak self] _ in
            sender.isUserInteractionEnabled = true
            
            self?.delegate?.didFinishCreatingNote()
            self?.closeNote(sender: self!.saveButton)
        }
    }
    
}

// MARK: PRIVATE

extension NoteController {
    
    /*
     * Configure all UI elements
     */
    fileprivate func configureUI() {
        // Configure add button
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
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

