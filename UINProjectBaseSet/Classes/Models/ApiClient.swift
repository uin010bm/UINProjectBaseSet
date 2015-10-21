//
//  apiClient.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/16.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



/// AlamofireのレスポンスをGenericsの型に変換するためのprotocol
public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}



/// Apiとのコネクトを統括するためのクラス
public class ApiClient {
    
    
    // MARK: - public enum
    
    /// Apiエラーハンドリングのためのenum type
    ///
    ///  - TimeOut:   サーバタイムアウトエラー
    ///  - BadParams: BadParamエラー
    ///  - Unknown:   不明なエラー
    public enum ApiError: String {
        case TimeOut = "ErrorApiTimeOut"
        case BadParams = "ErrorApiBadParams"
        case Unknown = "ErrorApiUnknown"
    }
    
    
    // MARK: - singleton
    public class var sharedInstance : ApiClient {
        struct Static {
            static let instance : ApiClient = ApiClient()
        }
        return Static.instance
    }
    
    
    
    // MARK: - public property
    
    /// Alamofireのmanager格納用変数
    public var alamoFireManager: Alamofire.Manager?
    
    /// ApiのbaseHostを取得する
    public var apiHostString: String {
        let baseURLString = NSBundle.mainBundle().objectForInfoDictionaryKey("BaseApiHost") as! String
        return baseURLString
    }

    
    
    // MARK: - initializer
    
    /// Alamofireのconfigrationを設定するinitializer
    ///
    ///  - returns: instance
    public init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 4 // seconds
        configuration.timeoutIntervalForResource = 4
        self.alamoFireManager = Alamofire.Manager(configuration: configuration)
    }
    
    
    
    // MARK: - public functions
    
    /// NSErrorからApiErrorのtypeを判別する関数
    ///
    ///  - parameter error: NSError
    ///
    ///  - returns: ApiError enum
    public func handleError(error: NSError) -> ApiError {
        
        switch error.code {
        case 1011:
            return ApiError.TimeOut
        case 403:
            return ApiError.BadParams
        default:
            return ApiError.Unknown
        }
    }
    
}
