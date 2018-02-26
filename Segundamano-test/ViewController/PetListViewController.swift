//
//  PetListViewController.swift
//  Segundamano-test
//
//  Created by Carmen Salvador Bucio on 2/16/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit

class PetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var uitableview: UITableView!

    final let urlDogNames = "https://dog.ceo/api/breeds/list"
    var dogNameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDogNames()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK: TABLEVIEW CONFIG
    func getDogNames (){
        let url = NSURL(string: urlDogNames)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if (jsonObj!.value(forKey: "status") as? String == "success"){
                    if let dogsNameArray = jsonObj!.value(forKey: "message") as? NSArray {
                        for dogName in dogsNameArray{
                            self.dogNameArray.append(dogName as! String)
                        }
    //                    print (self.dogNameArray)
                    }
                    OperationQueue.main.addOperation({
                        self.uitableview.reloadData()
                    })
                }
                else {
                    self.dogNameArray = ["No se pudo obtener información"]
                }
            }
        }).resume()
    }

//MARK: TABLEVIEW CONFIG
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.uiNameDog.text = dogNameArray[indexPath.row]
        cell.uiImageDog.image = nil
        return cell
    }
}
