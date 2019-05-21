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
    var detailBook: Book?
    
    private let refrshControl = UIRefreshControl()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Navigation Bar Title
        self.title = "kFlippFlopp".localized
        
        // Hide tableview before retrieving data
        self.booksTableView.isHidden = true
        
        // Setup refresh control for tableview
        if #available(iOS 10.0, *) {
            booksTableView.refreshControl = refrshControl
        } else {
            booksTableView.addSubview(refrshControl)
        }
        
        // Set up notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadTableViewData), name: NSNotification.Name(rawValue: bestSellerBooksFetchedNotification), object: nil)
        
        if DataManager.sharedInstance.retrieveStoredData() {
            loadTableViewData()
        } else {
            NetworkManager.sharedInstance.executeRequest(urlString: NetworkCommands.listData.rawValue, isbn: nil, author: nil)
        }
        
        // Configure refresh control
        refrshControl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
        refrshControl.attributedTitle = NSAttributedString(string: "kRefreshingBestSellerList".localized, attributes: nil)
    }
    
    func reloadTableViewData() {
        booksTableView.reloadData()
        booksTableView.isHidden = false
        DataManager.sharedInstance.updateStorage()
    }
    
    @objc func loadTableViewData() {
        if let bookResults = DataManager.sharedInstance.bestSellerResults, let _ = bookResults.books {
            reloadTableViewData()
            self.refrshControl.endRefreshing()
        }
    }
    
    @objc func refreshTableView() {
        NetworkManager.sharedInstance.executeRequest(urlString: NetworkCommands.listData.rawValue, isbn: nil, author: nil)
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        detailBook = DataManager.sharedInstance.bestSellerResults?.books?[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailBook = DataManager.sharedInstance.bestSellerResults?.books?[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.sharedInstance.bestSellerResults?.books?.remove(at: indexPath.row)
            reloadTableViewData()
        }
    }
    
    func getDataFromImageURL(urlString: String) -> Data? {
        var imageData: Data?
        if let url = URL(string: urlString) {
            imageData = try? Data(contentsOf: url)
        }
        return imageData
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookDetailSegue", let booksDetailController = segue.destination as? BooksDetailViewController {
            booksDetailController.bookObj = detailBook
        }
    }
}

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

