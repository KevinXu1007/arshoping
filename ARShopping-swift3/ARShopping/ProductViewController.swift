//
//  DetailViewController.swift
//  ARShopping
//
//  Created by Chenggang Xu on 11/20/16.
//  Copyright © 2016 Chenggang Xu. All rights reserved.
//

import UIKit

class ProductViewController: UITableViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    fileprivate var products = [Product]()
    var categoryId: Int = 0


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Category? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    fileprivate func setup() {
        
        categoryId = (self.detailItem?.id)!
        let APIURL = "\(Constant.ServiceUrl)/\(Constant.ProductByCategoryRequest)/\(categoryId)/1"
        
        let url = URL(string: APIURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    _ = 0
                    _ = ""
                    _ = ""
                    _ = ""
                    _ = 0.0
                    _ = 0.0
                    
                    if let dictionary = parsedData as? [String: Any] {
                        //print(dictionary)
                        
                        if let nestedDictionary = dictionary["products"] as? [[String:Any]] {
                            // access nested dictionary values by key
                            for catalog in nestedDictionary{
                                let product = Product()
                                
                                if let pname:String = catalog["pname"] as? String{
                                    product.name = pname
                                }
                                
                                if let pimage:String = catalog["image"] as? String{
                                    product.image = pimage
                                }
                                if let desc:String = catalog["pdesc"] as? String{
                                    product.description = desc
                                }
                                if let pmarket:Double = catalog["market_price"] as? Double{
                                    product.market_price = pmarket
                                }
                                if let pshop:Double = catalog["shop_price"] as? Double{
                                    product.shop_price = pshop
                                }
                                
                                if let pid:Int = catalog["pid"] as? Int{
                                    product.id = pid
                                }
                                
                                self.products.append(product)
                                //print(self.categories.count)
                            }
                            print(self.products.count)
                            
                            DispatchQueue.main.async(execute: { () -> Void in
                                self.tableView.reloadData()
                            })
                            //self.tableView.reloadData()
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        // register tap gesture
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MasterViewController.tapTableCell(_:)))
        //tapGestureRecognizer.delegate = self
        //self.tableView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = products[indexPath.row]
                //print(object)
                let controller = segue.destination as! ProductDetailController
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
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        let image = product.image
        let url = "\(Constant.ImageUrl)/\(image)"
        
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = String(product.shop_price)
        cell.productImageView.downloadedFrom(link: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


}


