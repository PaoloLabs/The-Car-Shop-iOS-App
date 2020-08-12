//
//  CategoryHandler.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class CategoryHandler: NSObject {
    static let sharedInstance = CategoryHandler()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let entityName = "Category"
    private override init() { }

    func createCategory(key: String, value: String) {
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let categoryEntity = NSEntityDescription.entity(forEntityName: self.entityName, in: managedContext)!
        let category = NSManagedObject(entity: categoryEntity, insertInto: managedContext)
        category.setValue(key, forKey: "key")
        category.setValue(value, forKeyPath: "value")
        //Now we have set all the values. The next step is to save them inside the Core Data
        do {
            try managedContext.save()
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() -> [CategoryData] {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            var arrayData = [CategoryData]()
            for data in result as! [NSManagedObject] {
                let item = CategoryData(key: data.value(forKey: "key") as! String, value: data.value(forKey: "value") as! String)
                arrayData.append(item)
            }
            return arrayData
        } catch {
            print("Failed")
            return [CategoryData]()
        }
    }
    
    func updateData(key: String, value: String, criteria: String) {
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
             
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: self.entityName)
        fetchRequest.predicate = NSPredicate(format: "key = %@", criteria)
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(key, forKey: "value")
                objectUpdate.setValue(value, forKey: "key")
            do {
                try managedContext.save()
            }
            catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteData(criteria: String) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        fetchRequest.predicate = NSPredicate(format: "key = %@", criteria)
       
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
   
}
