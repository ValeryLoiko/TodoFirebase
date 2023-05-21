//
//  TasksViewController.swift
//  ToDoFirebase
//
//  Created by Diana on 21/05/2023.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    
}
