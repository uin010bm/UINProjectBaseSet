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



public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}



class ApiClient {
    
    /**
    ErrorTypes for network error hundling.
    
    - TimeOut:   server timeout error.
    - BadParams: badparams error.
    - Unknown:   unknown error.
    */
    enum ApiError: String {
        case TimeOut = "ErrorApiTimeOut"
        case BadParams = "ErrorApiBadParams"
        case Unknown = "ErrorApiUnknown"
    }
    
    
    /// manager setted configration.
    internal var alamoFireManager : Alamofire.Manager?
    
    
    /// singleton instance.
    internal class var sharedInstance : ApiClient {
        struct Static {
            static let instance : ApiClient = ApiClient()
        }
        return Static.instance
    }
    
    
    /**
    Initializer will set configration.
    
    :returns:
    */
    init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 4 // seconds
        configuration.timeoutIntervalForResource = 4
        self.alamoFireManager = Alamofire.Manager(configuration: configuration)
    }
    
    
    /**
    For hundling network error types.
    
    :param: error set NSError
    
    :returns: ApiError enum
    */
    internal func handleError(error: NSError) -> ApiError {
        
        switch error.code {
        case 400:
            return ApiError.TimeOut
        default:
            return ApiError.Unknown
        }
    }
    
}



// MARK: - Alamofire's Request extension
extension Request {
    
    /**
    This function make value from Generics Type.
    
    :param: completionHandler set block and attribute response converted to type of Generics
    
    :returns: Request obj
    */
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let
                    response = response,
                    responseObject = T(response: response, representation: value)
                {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}



// MARK: - SwiftyJSON's JSON extension
extension JSON: ResponseObjectSerializable {
    
    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.init(representation as! Dictionary)
    }
}