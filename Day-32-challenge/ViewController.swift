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
        
        textList = ["1", "2", "3", "4"]
    }
    
    @objc func openAlert() {
        
        let alertController = UIAlertController(
            title: "Add Item",
            message: nil,
            preferredStyle: .alert
        )
        alertController.addTextField()
        
        let action = UIAlertAction(title: "Submit", style: .default) { [ weak self, weak alertController] _ in
            guard let text = alertController?.textFields?[0].text else { return }
            self?.addText(text: text)
        }
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @objc func resetTable(){
        let ac = UIAlertController(
            title: "Delete",
            message: "Are you sure to delete all the elements?",
            preferredStyle: .actionSheet
        )
        
        let confirmAction = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.textList.removeAll()
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        ac.addAction(confirmAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
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
    
    func addText(text: String){
        textList.insert(text, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
    override func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint) -> UIContextMenuConfiguration? {
       
        let deleteAction = UIAction(
            title: "Delete",
            image: UIImage(systemName: "minus.circle")) { [weak self] _ in
            self?.deleteItem(indexRow: indexPath.row)
        }
        
        let shareAction = UIAction(
            title: "Share",
            image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
            self?.sharedItem(indexRow: indexPath.row)
        }
        
        let menu = UIMenu(title: "", children: [deleteAction, shareAction])
        
        return UIContextMenuConfiguration(identifier: nil, actionProvider:  { _ in
            return menu
        })
    }
    
    func deleteItem(indexRow: Int){
        textList.remove(at: indexRow)
        tableView.deleteRows(at: [IndexPath(row: indexRow, section: 0)], with: .bottom)
    }
    
    func sharedItem(indexRow: Int){
        let textRow = textList[indexRow]
        let ac = UIActivityViewController(
            activityItems: [textRow],
            applicationActivities: nil
        )
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }



}

