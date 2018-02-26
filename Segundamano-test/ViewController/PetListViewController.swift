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
    var dogImageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDogNames()
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
                            self.getImageDog(dogName: dogName as! String)
                        }
                    }
                    OperationQueue.main.addOperation({
                        self.uitableview.reloadData()
                    })
                }
            }
        }).resume()
    }
    func getImageDog(dogName:String){
        let urlImageDog = "https://dog.ceo/api/breed/\(dogName)/images"
        let url = NSURL(string: urlImageDog)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if (jsonObj!.value(forKey: "status") as? String == "success"){
//                    self.dogNameArray.append(dogName)
                    if let dogsImagesArray = jsonObj!.value(forKey: "message") as? NSArray {
                        let randomVal = self.randomNum(dogsImagesArray.count)
                        self.dogImageArray.append(dogsImagesArray[randomVal] as! String)
                    }
                }
//                OperationQueue.main.addOperation({
                    self.uitableview.reloadData()
//                })
            }
        }).resume()
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    private func randomNum(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

//MARK: TABLEVIEW CONFIG
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.uiNameDog.text = dogNameArray[indexPath.row]
        if dogImageArray.count > 0 {
            let imgURL = NSURL(string: dogImageArray[indexPath.row])
            if imgURL != nil {
                getDataFromUrl(url: URL(string: dogImageArray[indexPath.row])!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    //            print(response?.suggestedFilename ?? url.lastPathComponent)
                    print("Download Finished")
//                    DispatchQueue.main.async() {
                        cell.uiImageDog.image = UIImage(data: data)
//                    }
                }
            }
        }
        return cell
    }
}
