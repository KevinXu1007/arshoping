//
//  BuyViewController.swift
//  ARShopping
//
//  Created by Chenggang Xu on 11/27/16.
//  Copyright © 2016 Chenggang Xu. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(url!)
        webView.delegate = self
        self.webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }
    
    @IBAction func backToPrev(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // UIWebView object has fully loaded.
        if(webView.stringByEvaluatingJavaScript(from: "document.readyState") == "complete") {
            
        }
        
        print("Webview did finish load")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
