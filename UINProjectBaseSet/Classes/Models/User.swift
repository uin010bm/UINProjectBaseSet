//
//  User.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/19.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire



// MARK: - User struct
internal struct User: ResponseObjectSerializable {
    
    let name: String
    
    /**
    Initialize from ResponsObjectSerializable Protocol
    */
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.name = representation.valueForKeyPath("name") as! String
    }
    
    
    /**
    Initialize from JSON
    */
    init?(json: JSON) {
        self.name = json["name"].string!
    }

}



// MARK: - UserService
internal class UserService {
    
    
    // Get User struct from Api.
    internal class func getUserFromApi(name: String, completion: (Response<User, NSError>) -> Void) {
        
        let url = ""
        let param:[String: AnyObject] = [
            "name" : name
        ]
        
        ApiClient.sharedInstance.alamoFireManager?.request(.GET, url, parameters: param, encoding: .JSON, headers: nil).responseObject({ (response: Response<User, NSError>) in
            completion(response)
        })
    }
}



// MARK: - UserService
internal class UserListModel {
    
    internal var list = [User]()
    
    
    /**
    Get User Array from Api.
    
    :param: completion set block can get User Array or NSError from attribute.
    */
    internal func getUserListFromApi(completion: ([User]?, NSError?) -> Void) {
        
        let url = ""
        let param:[String: AnyObject] = [:]
        
        ApiClient.sharedInstance.alamoFireManager?.request(.GET, url, parameters: param, encoding: .JSON, headers: nil).responseObject({ [weak self] (response: Response<JSON, NSError>) in
            self?.setupModel(response, completion: { (list: [User]?, error: NSError?) in
                completion(list, error)
            })
        })
    }
    
    
    /**
    Setup list from jsons which got from api.
    
    :param: response   set response from api
    :param: completion set block can get User Array or NSError from attribute.
    */
    internal func setupModel(response: Response<JSON, NSError>, completion: ([User]?, NSError?) -> Void) {
        
        if response.result.isFailure {
            completion(nil, response.result.error)
        } else {
            
            for value in response.result.value!.array! {
                
                let user = User(json: value)
                self.list.append(user!)
                
            }
            completion(self.list, nil)
        }
    }
}
