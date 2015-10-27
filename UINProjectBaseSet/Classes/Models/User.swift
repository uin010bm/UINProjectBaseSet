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
    public class func getUserFromApi(name: String, completion: (User?, ApiErrorType) -> Void) {
        
        let url = ApiClient.sharedInstance.apiHostString + "/user"
        let param:[String: AnyObject] = [
            "name" : name
        ]
        
        #if DEBUG
            let stubFile = "StubUserApi.json"
            ApiClient.setStub(200, url: url, file: stubFile, forClass: self)
        #endif
        
        ApiClient.sharedInstance.alamoFireManager?.request(.GET, url, parameters: param, encoding: .URLEncodedInURL, headers: nil).responseObject({ (response: Response<User, NSError>) in
            let type = ApiClient.getApiErrorType(response.response!.statusCode)
            completion(response.result.value, type)
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
    private func setupUserListFromJSON(response: Response<JSON, NSError>, completion: ([User]?, Response<JSON, NSError>) -> Void) {
        
        if response.result.isFailure {
            completion(nil, response)
        } else {
            
            for value in response.result.value!.array! {
                
                let user = User(json: value)
                self.list.append(user!)
                
            }
            completion(self.list, response)
        }
    }
    
    
    
    // MARK: - public functions
    
    ///  Apiからユーザリストを取得する
    ///
    ///  - parameter completion: 完了時ブロック構文。引数にUserArray または errorを渡す。
    public func getUserListFromApi(completion: ([User]?, ApiErrorType) -> Void) {
        
        let url = ApiClient.sharedInstance.apiHostString + "/userList"
        
        #if DEBUG
            let stubFile = "StubUserListApi.json"
            ApiClient.setStub(200, url: url, file: stubFile, forClass: self.dynamicType)
        #endif
        
        ApiClient.sharedInstance.alamoFireManager?.request(.GET, url, parameters: nil, encoding: .URLEncodedInURL, headers: nil).responseObject({ [weak self] (response: Response<JSON, NSError>) in
            self?.setupUserListFromJSON(response, completion: { (users: [User]?, response: Response<JSON, NSError>) in
                let type = ApiClient.getApiErrorType(response.response!.statusCode)
                completion(users, type)
            })
        })
    }

}
