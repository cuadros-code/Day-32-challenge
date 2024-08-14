//
//  ViewController.swift
//  Day-32-challenge
//
//  Created by Kevin Cuadros on 14/08/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var textList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(openAlert)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(resetTable)
        )
    }
    
    @objc func openAlert() {
        
        let ac = UIAlertController(
            title: "",
            message: nil,
            preferredStyle: .alert
        )
        ac.addTextField()
        
    }
    
    @objc func resetTable(){
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = textList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }


}

