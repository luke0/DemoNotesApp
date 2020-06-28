//
//  DetailViewController.swift
//  MilestoneNotesApp
//
//  Created by Luke Inger on 28/06/2020.
//  Copyright © 2020 Luke Inger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var selectedNote: Note?
    var allNotes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let note = selectedNote {
            self.textView.text = note.Content
        } else {
            selectedNote = Note(with: "")
        }
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(share))
    }
    
    @objc func save(){
        
        selectedNote?.Content = self.textView.text
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "notes") as? Data {
            let jsonDecode = JSONDecoder()
            do {
                allNotes = try jsonDecode.decode([Note].self, from: savedPeople)
            } catch {
                print("Failed")
            }
        }
        
        if let noteToSave = selectedNote {
            for (index,note) in allNotes.enumerated() {
                if note.id == noteToSave.id{
                    allNotes.remove(at: index)
                }
            }
            allNotes.append(noteToSave)
            let jsonEncoder = JSONEncoder()
            if let savedDate = try? jsonEncoder.encode(allNotes){
                let defaults = UserDefaults.standard
                defaults.set(savedDate, forKey: "notes")
            } else {
                print("Failed")
            }
        }

        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func share(){
        
        guard let content = selectedNote?.Content else { return }
        
        let vc = UIActivityViewController(activityItems: [content], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
