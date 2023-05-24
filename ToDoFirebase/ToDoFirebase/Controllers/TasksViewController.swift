//
//  TasksViewController.swift
//  ToDoFirebase
//
//  Created by Diana on 21/05/2023.
//

import UIKit
import Firebase

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User!
    var ref: DatabaseReference!
    var tasks: [Task] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "This is number \(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alert = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alert.addTextField()
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let textField = alert.textFields?.first, textField.text != "" else { return }
            let task = Task(title: textField.text!, userID: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary())
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true)
    }
}
