//
//  AddBookVC.swift
//  TestCoreData
//
//  Created by MacBook on 29/03/2022.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class AddBookVC: UIViewController {
    
    @IBOutlet weak var titletxtField: UITextField!
    @IBOutlet weak var authortxtField: UITextField!
    
    var selectedBook: Books? = nil
    var isEdit = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedBook != nil {
            let context = appDelegate?.persistentContainer.viewContext
                titletxtField.text =  selectedBook?.title
                authortxtField.text = selectedBook?.author
            do {
                try context?.delete(selectedBook!)
            } catch {
                print("Delete Successfully")
            }
        }
        
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
            save { completion in
                if completion {
                    navigationController?.popViewController(animated: true)
                } else {
                    print("Failed")
                }
            }
    }
    
    
    func save(completion: (_ completion: Bool) -> ()) {
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let userData = Books(context: context)
        userData.title = titletxtField.text
        userData.author = authortxtField.text
        do {
            try context.save()
            completion(true)
        } catch {
            print("Data Not Added")
            completion(false)
        }
    }
    
    
    
}
