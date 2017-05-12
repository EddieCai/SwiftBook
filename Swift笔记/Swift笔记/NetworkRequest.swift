//
//  NetworkRequest.swift
//  Swift笔记
//
//  Created by 曾觉新 on 2017/5/11.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit
import Alamofire

class NetworkRequest: NSObject {
    
    
    
    class func fetchNetworkData(url: String, parameters: Dictionary<String, Any>?, method: HTTPMethod, success: @escaping ((Dictionary<String, Any>)->()), failure: (() -> ())? = nil) {
        
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (dataResponse) in
            if dataResponse.result.error != nil {
                failure?()
            } else {
                guard let json = dataResponse.result.value else {
                    failure?()
                    return
                }
                print("##########\(json)")
                let result: Dictionary<String, Any> = json as! Dictionary
//                let code: String = (result["status"] as? String)!
//                if code == "ok" {
//                    success(result)
//                } else {
//                    failure?()
//                }
                
                
            }
            
            
        }
        
        
        
    }
    

    

}
