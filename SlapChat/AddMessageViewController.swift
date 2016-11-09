//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Henry Chan on 11/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {
    
    var store = DataStore.sharedInstance
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        let managedContext = store.persistentContainer.viewContext
        let displayedMessage = Message(context: managedContext)
        displayedMessage.content = textField.text
        displayedMessage.createdAt = NSDate()
        
        store.saveContext()
        
        
        dismiss(animated: true, completion: nil)
    }

  

}
