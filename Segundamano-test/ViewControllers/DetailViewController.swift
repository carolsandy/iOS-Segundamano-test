//
//  DetailViewController.swift
//  Segundamano-test
//
//  Created by Jonathan Pabel on 19/02/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var name:String = ""
    var dataSource:[String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    self.title = name

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogDetailTableViewCell") as! DogDetailTableViewCell
        cell.itemImage = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.00
    }
}


