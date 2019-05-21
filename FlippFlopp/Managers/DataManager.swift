//
//  DataManager.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit
import ObjectMapper

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    var bestSellerResults: BookResults?
    
    func saveStorage() {
        PersistenceManager.sharedInstance.saveData(persistResults: bestSellerResults)
    }
    
    func updateStorage() {
        let _ = PersistenceManager.sharedInstance.fetchAndUpdateData(updateResults: bestSellerResults)
    }
    
    func retrieveStoredData() -> Bool {
        var isRetrieved = false
        if let jsonString = PersistenceManager.sharedInstance.fetchAndUpdateData(updateResults: nil) {
            self.bestSellerResults = Mapper<BookResults>().map(JSONString: jsonString)
            isRetrieved = true
        }
        return isRetrieved
    }

}
