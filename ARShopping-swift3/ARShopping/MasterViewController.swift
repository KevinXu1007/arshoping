//
//  MasterViewController.swift
//  ARShopping
//
//  Created by Chenggang Xu on 11/20/16.
//  Copyright © 2016 Chenggang Xu. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UIGestureRecognizerDelegate {

    var detailViewController: ProductViewController? = nil
    var objects = [Any]()
    fileprivate var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ProductViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func setup() {
        
        
        let APIURL = "\(Constant.ServiceUrl)/\(Constant.AllCategoryRequest)"
        
        let url = URL(string: APIURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    var id = 0
                    var name = ""
                    var image = ""
                    
                    if let dictionary = parsedData as? [String: Any] {
                        
                        if let nestedDictionary = dictionary["catalog"] as? [[String:Any]] {
                            for catalog in nestedDictionary{
                                if let cname:String = catalog["csname"] as? String{
                                    name = cname
                                }
                                if let cid:Int = catalog["csid"] as? Int{
                                    id = cid
                                }
                                let category = Category()
                                category.id = id
                                category.name = name
                                self.categories.append(category)
                            }
                            print(self.categories.count)
                            
                            DispatchQueue.main.async(execute: { () -> Void in
                                self.tableView.reloadData()
                            })
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
    }

    // MARK: Tab handler
    func tapTableCell(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let location = gestureRecognizer.location(in: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: location) {
            if let row = self.tableView.cellForRow(at: indexPath){
                performSegue(withIdentifier: "productList", sender: row)
            }
        }
    }
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productList" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = categories[indexPath.row]
                print(object)
                let controller = (segue.destination as! UINavigationController).topViewController as! ProductViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let category = categories[indexPath.row]
        cell.textLabel!.text = category.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func didSaveUser(_ content: [String]) {}

    func checkUserInfo(_ content: String)->Bool{
        return false
    }

}

