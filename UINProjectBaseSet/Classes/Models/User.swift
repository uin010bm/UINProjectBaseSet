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



/// ユーザ情報を格納するためのstructオブジェクト
public struct User: ResponseObjectSerializable {
    
    // MARK: - public property
    
    /// ユーザ名
    public let json: JSON
    public var name: String {
        return json["name"].string!
    }
    
    
    // MARK: - initializer
    
    /// Alamofire の Response に対応したイニシャライザ。ResponsObjectSerializable Protocol準拠
    ///
    ///  - parameter response:       apiレスポンス
    ///  - parameter representation: convert済みのAnyObject
    ///
    ///  - returns: instance
    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.json = JSON(representation)
    }
    
    
    /// JSON用イニシャライザ
    ///
    ///  - parameter json: JSON object
    ///
    ///  - returns: instance
    public init?(json: JSON) {
        self.json = json
    }

}



/// 単独ユーザ情報をApiから取得するためのService
public class UserService {
    
    
    // MARK: - public class functions
    
    /// Apiから単独ユーザ情報を取得する
    ///
    ///  - parameter name:       ターゲットとなるユーザ名
    ///  - parameter completion: 完了時ブロック構文。引数にUserジェネリクスのResponseを渡す。
    public class func getUserFromApi(name: String, completion: (Response<User, NSError>) -> Void) {
        
        let url = ApiClient.sharedInstance.apiHostString + "/user"
        let param:[String: AnyObject] = [
            "name" : name
        ]
        
        ApiClient.sharedInstance.alamoFireManager?.request(.GET, url, parameters: param, encoding: .URLEncodedInURL, headers: nil).responseObject({ (response: Response<User, NSError>) in
            completion(response)
        })
    }
}



/// ユーザリストを管理するためのモデル
public class UserListModel {
    
    
    // MARK: - public property
    
    /// ユーザリスト格納用Array
    public var list = [User]()
    
    
    // MARK: - private functions
    
    ///  ApiのレスポンスからUserArrayを生成するための関数
    ///
    ///  - parameter response:   JSONジェネリクスのResponseオブジェクト
    ///  - parameter completion: 完了時ブロック構文。引数にUserArray または errorを渡す。
    private func setupUserListFromJSON(response: Response<JSON, NSError>, completion: ([User]?, NSError?) -> Void) {
        
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
    
    
    
    // MARK: - public functions
    
    ///  Apiからユーザリストを取得する
    ///
    ///  - parameter completion: 完了時ブロック構文。引数にUserArray または errorを渡す。
    public func getUserListFromApi(completion: ([User]?, NSError?) -> Void) {
        
        let url = ""
        let param:[String: AnyObject] = [:]
        
        ApiClient.sharedInstance.alamoFireManager?.request(.GET, url, parameters: param, encoding: .JSON, headers: nil).responseObject({ [weak self] (response: Response<JSON, NSError>) in
            self?.setupUserListFromJSON(response, completion: { (list: [User]?, error: NSError?) in
                completion(list, error)
            })
        })
    }

}
