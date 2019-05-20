//
//  PersistenceManager.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/20/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreData

class PersistenceManager: NSObject {
    
    static let sharedInstance = PersistenceManager()
    
    func saveData(persistResults: BookResults?) {
        guard let appDelegateRef = UIApplication.shared.delegate as? AppDelegate, let persistJSONString = convertDataToJSONString(bookResults: persistResults) else { return }
        
        let managedContextForStorage = appDelegateRef.persistentContainer.viewContext
        let storageEntity = NSEntityDescription.entity(forEntityName: "StoredBookResults", in: managedContextForStorage)
        let storageObject = NSManagedObject(entity: storageEntity!, insertInto: managedContextForStorage)
        storageObject.setValue(persistJSONString, forKey: "resultsString")
        
        do {
            try managedContextForStorage.save()
        } catch let error as NSError {
            print("Bala Save failed; error = \(error), description = \(error.userInfo)")
        }
    }
    
    func fetchAndUpdateData(updateResults: BookResults?) -> String? {
        var fetchedString: String?
        guard let appDelegateRef = UIApplication.shared.delegate as? AppDelegate else { return fetchedString }
        
        // Step: 1 - Fetch the context
        let managedContextForFetch = appDelegateRef.persistentContainer.viewContext
        
        // Step: 2 - Create a fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoredBookResults")
        
        // Step: 3 - Fetch the created context
        do {
            let fetchedEntityArray = try managedContextForFetch.fetch(fetchRequest)
            if fetchedEntityArray.count > 0 {
                fetchedString = fetchedEntityArray[0].value(forKey: "resultsString") as? String
                // To update core data
                if let uResultString = convertDataToJSONString(bookResults: updateResults) {
                    fetchedEntityArray[0].setValue(uResultString, forKey: "resultsString")
                    try managedContextForFetch.save()
                }
            }
        } catch let error as NSError {
            print("Bala Fetch failed; error = \(error), description = \(error.userInfo)")
        }
        return fetchedString
    }
    
    func retrieveStoredData() -> Bool {
        var isRetrieved = false
        if let jsonString = fetchAndUpdateData(updateResults: nil) {
            DataManager.sharedInstance.bestSellerResults = Mapper<BookResults>().map(JSONString: jsonString)
            isRetrieved = true
        }
        return isRetrieved
    }
    
    private func convertDataToJSONString(bookResults: BookResults?) -> String? {
        var jsonString: String?
        if let bookResultRef = bookResults {
            jsonString = Mapper().toJSONString(bookResultRef)
        }
        return jsonString
    }
    
}
