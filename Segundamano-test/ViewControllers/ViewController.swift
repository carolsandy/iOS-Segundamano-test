//
//  ViewController.swift
//  Segundamano-test
//
//  Created by Carmen Salvador Bucio on 2/16/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource:[DogModel] = [DogModel]()
    private var imageAux:[String] = [String]()
    private var selectedBreed:[String] = [String]()
    private var selectedName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDogList()
    }
    private func loadDogList() {
        let url = URL(string: "https://dog.ceo/api/breeds/list")!
        Alamofire.request(url).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                if let response = value as? NSDictionary {
                    if let values = response.object(forKey: "message") as? NSArray {
                        for name in values {
                            if let breed = name as? String {
                                let imageURL = "https://dog.ceo/api/breed/\(breed)/images"
                                self.loadPhotosArrayFrom(name: breed, breedUrl: imageURL)
                            }
                        }
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert()
            }
        }
    }
    
    private func loadPhotosArrayFrom(name:String,breedUrl:String) {
   
        if let urlRequest = URL(string: breedUrl) {
            Alamofire.request(urlRequest).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let value):
                    if let response = value as? NSDictionary {
                        if let values = response.object(forKey: "message") as? NSArray {
                            for image in values {
                                if let imageString = image as? String {
                                self.imageAux.append(imageString)
                                }
                            }
                            let randomNumberIndex = self.random(self.imageAux.count)
                            let dogModel = DogModel(name: name, imageURL: breedUrl, coverURL: self.imageAux[randomNumberIndex], arrayURLs: self.imageAux)
                            self.dataSource.append(dogModel)
                            self.imageAux.removeAll()
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.showAlert()
                }
            })
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Oups!", message: "Algo salió mal, intenta más tarde", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    // MARK: -Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.dataSource = selectedBreed
            detailViewController.name = selectedName
        }
    }
    
}

// MARK: -UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "DogTableViewCell") as! DogTableViewCell
        cell.dogItem = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selected = dataSource[indexPath.row].arrayURLs {
            selectedBreed = selected
            selectedName = dataSource[indexPath.row].name
            performSegue(withIdentifier: "DetailViewController", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.00
    }
}

