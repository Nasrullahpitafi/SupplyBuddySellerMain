//
//  WebService.swift
//  RozeePk
//
//  Created by nassrullah khan on 31/10/2020.
//  Copyright © 2020 nassrullah khan. All rights reserved.
//

import Foundation
import Alamofire

class RemoteRequest: NSObject {
    
    
    class func requestPostURL(_ strURL: String,params:Parameters, success:@escaping (Any) -> Void, failure:@escaping (NSError) -> Void) {
        let header = [
            "Content-Type":"application/json"
        ]
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            print("POST \(strURL)")
            print(params)
            print(response)
            if response.error == nil {
                
                guard let value = response.value as? NSDictionary else{
                    print("Error while fetching : \(String(describing: response.value))")
                    return
                }
                success(value)
            }else{
                print(response.error?.localizedDescription ?? "")
                failure(NSError(domain: response.error?.localizedDescription ?? "", code: 400, userInfo: nil))
            }
            
        }
        
    }
    
    class func requestGetURL(_ strURL: String,params:Parameters, success:@escaping (Any) -> Void, failure:@escaping (NSError) -> Void) {
        let header = [
            "Content-Type":"application/json"
        ]
        Alamofire.request(strURL, method: .get, parameters: params, headers: header).responseJSON { response in
            print("GET \(strURL)")
            print(params)
            print(response)
            if response.error == nil {
                
                guard let value = response.value as? NSDictionary else{
                    print("Error while fetching : \(String(describing: response.value))")
                    return
                }
                success(value)
            }else{
                print(response.error?.localizedDescription ?? "")
                failure(NSError(domain: response.error?.localizedDescription ?? "", code: 400, userInfo: nil))
            }
            
        }
        
    }
    class func requestPutURL(_ strURL: String,params:Parameters, success:@escaping (Any) -> Void, failure:@escaping (NSError) -> Void) {
        let header = [
            "Content-Type":"application/json"
        ]
        Alamofire.request(strURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            print("PUT \(strURL)")
            print(params)
            print(response)
            if response.error == nil {
                
                guard let value = response.value as? NSDictionary else{
                    print("Error while fetching : \(String(describing: response.value))")
                    return
                }
                success(value)
            }else{
                print(response.error?.localizedDescription ?? "")
                failure(NSError(domain: response.error?.localizedDescription ?? "", code: 400, userInfo: nil))
            }
            
        }
        
    }
    class func requestDeleteURL(_ strURL: String,params:Parameters, success:@escaping (Any) -> Void, failure:@escaping (NSError) -> Void) {
        let header = [
            "Content-Type":"application/json"
        ]
        Alamofire.request(strURL, method: .delete, parameters: params, headers: header).responseJSON { response in
            print("DELETE \(strURL)")
            print(params)
            print(response)
            if response.error == nil {
                
                guard let value = response.value as? NSDictionary else{
                    print("Error while fetching : \(String(describing: response.value))")
                    return
                }
                success(value)
            }else{
                print(response.error?.localizedDescription ?? "")
                failure(NSError(domain: response.error?.localizedDescription ?? "", code: 400, userInfo: nil))
            }
            
        }
        
    }
    
    
}




