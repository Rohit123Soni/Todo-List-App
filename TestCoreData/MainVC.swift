//
//  ViewController.swift
//  TestCoreData
//
//  Created by MacBook on 29/03/2022.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bookList = [Books]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .init(white: 0.95, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetch { complete in
            if complete {
                print("Data Loaded")
                tableView.reloadData()
            } else {
                print("Faileeeddd")
            }
        }
    }

    func fetch(completion: (_ completion: Bool)-> ()) {
        if let context = appDelegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
            do {
                bookList = try context.fetch(fetchRequest) as! [Books]
                completion(true)
            } catch {
                print("Data did not fetch!!!!")
                completion(false)
            }
        }
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let cellData = bookList[indexPath.row]
        cell.configure(title: cellData.title ?? "N/A", author: cellData.author ?? "N/A")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = appDelegate?.persistentContainer.viewContext
        if editingStyle == .delete {
            context?.delete(bookList[indexPath.row])
            bookList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            do {
                try context?.save()
            } catch {
                print("Did not delete")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editData" {
            let indexPath = tableView.indexPathForSelectedRow!
            let vc = segue.destination as? AddBookVC

            let selectedBook : Books!
            selectedBook = bookList[indexPath.row]
            vc?.selectedBook = selectedBook
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

