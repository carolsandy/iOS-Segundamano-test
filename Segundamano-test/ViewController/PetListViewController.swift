//
//  PetListViewController.swift
//  Segundamano-test
//
//  Created by Carmen Salvador Bucio on 2/16/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit

class PetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let animals = ["A","B","C"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (animals.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.uiNameDog.text = animals[indexPath.row]
        cell.uiImageDog.image = nil
        return cell
    }
}
