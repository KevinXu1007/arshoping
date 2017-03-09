//
//  DetailViewController.swift
//  ARShopping
//
//  Created by Chenggang Xu on 11/20/16.
//  Copyright © 2016 Chenggang Xu. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var regPrice: UILabel!
    @IBOutlet weak var salePrice: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    var cItem = CartItem()
    
    func configureView() {
        // Update the user interface for the detail item.
        initView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = (self.detailItem?.image)!
        let url = "\(Constant.ImageUrl)/\(image)"
        //let url = "http://66.25.17.182/eshop/image/product/tommy.jpg"
        print(url)
        self.productImage.downloadedFrom(link: url)
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: Product? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func initView(){
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.name
            }
            
            if let label = self.regPrice {
                label.text = String(detail.market_price)
            }
            
            if let label = self.salePrice {
                label.text = String(detail.shop_price)
            }
            
            if let desc = self.desc {
                desc.text = detail.description
            }
        }
    }
    
   
    @IBAction func openAR(_ sender: Any) {
        let arViewController = storyboard?.instantiateViewController(withIdentifier: "ARController") as! AVCaptireVideoPicController
        let image = (self.detailItem?.image)!
        
        arViewController.modalPresentationStyle = .popover
        arViewController.imageUrl = "\(Constant.ImageUrl)/\(image)"
        present(arViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func toPurchase(_ sender: Any) {
        let buyViewController = storyboard?.instantiateViewController(withIdentifier: "buyview") as! BuyViewController
        
        buyViewController.modalPresentationStyle = .popover
        let productid = self.detailItem?.id
        let url:String = "\(Constant.ServiceUrl)/findByPid/\(productid!)"
        buyViewController.url = url
        present(buyViewController, animated: true, completion: nil)
    }
   
    
   
    
    
}


