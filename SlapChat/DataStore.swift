//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedInstance = DataStore()
    
    var messages = [Message]()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func fetchData() {
        
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        //Alternative Fetch Request
        // let fetchRequest = NSFectchRequest<Message> = Message.fetchRequest
        
        do{
            
            self.messages = try managedContext.fetch(fetchRequest)
            messages.sort(by: { (first, second) -> Bool in
                
                let firstMessage = first.createdAt as! Date
                let secondMessage = second.createdAt as! Date
                return firstMessage < secondMessage
            })
            
        }catch{
            fatalError("Failed to fetch messages: \(error)")
        }
        
        
        if messages.count == 0 {
            generateTestData()
        }
        
    }
    
    
    func generateTestData() {
        
        
        let managedContext = persistentContainer.viewContext
        
        //first message
//        let firstMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedContext) as! Message
        //Alternative way
        let firstMessage = Message(context: managedContext)
        firstMessage.content = "Yay first Message"
        firstMessage.createdAt = NSDate()
        
        
        //second message
        let secondMessage = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedContext) as! Message
        secondMessage.content = "Ok second Message"
        secondMessage.createdAt = NSDate()
        
        saveContext()
        fetchData()
        
        print ("This is the count again: \(messages.count)")
    }
    
}
