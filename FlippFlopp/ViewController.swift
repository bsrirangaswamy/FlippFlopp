//
//  ViewController.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var booksTableView: UITableView!
    
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
            booksTableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if let bookResults = DataManager.sharedInstance.bestSellerResults, let booksArray = bookResults.books {
            rowCount = booksArray.count
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        if let bookResults = DataManager.sharedInstance.bestSellerResults, let booksArray = bookResults.books {
            let currentBook = booksArray[indexPath.row]
            bookCell.bookTitleLabel.text = currentBook.title!
            bookCell.bookAuthorLabel.text = currentBook.author!
            if let imageData = currentBook.bookImageData {
                bookCell.bookImageView.image = UIImage(data: imageData)
            } else if let imageURLString = currentBook.bookImage, let newImageData = getDataFromImageURL(urlString: imageURLString) {
                DataManager.sharedInstance.bestSellerResults?.books?[indexPath.row].bookImageData = newImageData
                bookCell.bookImageView.image = UIImage(data: newImageData)
            }
        }
        return bookCell
    }
    
    func getDataFromImageURL(urlString: String) -> Data? {
        var imageData: Data?
        if let url = URL(string: urlString) {
            imageData = try? Data(contentsOf: url)
        }
        return imageData
    }
}

