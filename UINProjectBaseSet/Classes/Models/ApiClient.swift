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
import OHHTTPStubs


// MARK: - protocol

/// AlamofireのレスポンスをGenericsの型に変換するためのprotocol
public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}


// MARK: - global enum

/// Apiエラーハンドリングのためのenum type
///
///  - TimeOut:   サーバタイムアウトエラー
///  - BadParams: BadParamエラー
///  - Unknown:   不明なエラー
public enum ApiErrorType: Int {
    case None = 200
    case BadParams = 403
    case Unknown = 500
}


/// Apiとのコネクトを統括するためのクラス
public class ApiClient {
    
    
    // MARK: - public enum
    
    ///  Stubのresponseに格納するパラメータ群を格納するenum
    ///
    ///  - Stub: stubであることを明示するtype
    public enum HeaderSet {
        case Stub
        
        func getHeaders() -> [NSObject : AnyObject]? {
            switch self {
            case .Stub:
                return ["Content-Type":"application/json"]
            }
        }
    }
    
    
    
    // MARK: - singleton
    
    public class var sharedInstance : ApiClient {
        struct Static {
            static let instance : ApiClient = ApiClient()
        }
        return Static.instance
    }
    
    
    
    // MARK: - public class functions
    
    ///  Stubテスト用のレスポンスを設定するメソッド
    ///
    ///  - parameter statusCode:   返却されるstatusCodeを指定
    ///  - parameter url:          該当するUrlを指定
    ///  - parameter file:         返却されるfile名を指定
    ///  - parameter forClass:     スコープとなるclass名を設定
    ///  - parameter requestTime:  requestにかかる仮定時間を設定
    ///  - parameter responseTime: responseにかかる仮定時間を設定
    public class func setStub(statusCode: Int32 = 200, url: String = "", file: String = "", forClass: AnyClass, requestTime: NSTimeInterval = 1.0, responseTime: NSTimeInterval = 2.0) {
        OHHTTPStubs.stubRequestsPassingTest({ $0.URL! == url }) { request in
            return OHHTTPStubsResponse(fileAtPath: OHPathForFile(file, forClass)!, statusCode: statusCode, headers: HeaderSet.Stub.getHeaders()).requestTime(requestTime, responseTime: responseTime)
        }
    }
    
    
    /// NSErrorからApiErrorのtypeを判別する関数
    ///
    ///  - parameter error: NSError
    ///
    ///  - returns: ApiError enum
    public class func getApiErrorType(statusCode: Int) -> ApiErrorType {
        
        switch statusCode {
        case 200:
            return .None
        case 403:
            return .BadParams
        default:
            return .Unknown
        }
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
    
    
    

    
}
