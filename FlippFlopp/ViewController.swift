//
//  ViewController.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.dataMapped), name: NSNotification.Name(rawValue: bestSellerBooksFetchedNotification), object: nil)
        
        NetworkManager.sharedInstance.executeRequest(urlString: NetworkCommands.listData.rawValue, isbn: nil, author: nil)
    }
    
    @objc func dataMapped() {
        if let bookResults = DataManager.sharedInstance.bestSellerResults, let booksArray = bookResults.books {
            print("Bala books array = \(booksArray[0].title)")
        }
    }


}

