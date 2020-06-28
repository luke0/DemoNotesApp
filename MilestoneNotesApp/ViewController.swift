//
//  ViewController.swift
//  MilestoneNotesApp
//
//  Created by Luke Inger on 28/06/2020.
//  Copyright © 2020 Luke Inger. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allNotes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(composeNew))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "notes") as? Data {
            let jsonDecode = JSONDecoder()
            do {
                allNotes = try jsonDecode.decode([Note].self, from: savedPeople)
            } catch {
                print("Failed")
            }
        }
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = allNotes[indexPath.row].Content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailViewController(with: allNotes[indexPath.row])
    }
    
    @objc func composeNew(){
        goToDetailViewController(with: Note(with: ""))
    }
    
    func goToDetailViewController(with note:Note?){
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            if let newNote = note {
                vc.selectedNote = newNote
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

