//
//  HttpUtil.swift
//  ARShopping
//
//  Created by Chenggang Xu on 11/25/16.
//  Copyright © 2016 Chenggang Xu. All rights reserved.
//

import Foundation

class SWHttpUtil: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    
    func post(_ url: String, postString: String){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
}
