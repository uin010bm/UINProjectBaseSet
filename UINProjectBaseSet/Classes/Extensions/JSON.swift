//
//  JSON.swift
//  UINProjectBaseSet
//
//  Created by 田中　佑 on 2015/10/19.
//  Copyright © 2015年 yu_tanaka. All rights reserved.
//

import Foundation
import SwiftyJSON

/// SwiftyJSONの JSON型エクステンション
extension JSON: ResponseObjectSerializable {
    
    
    // MARK: - initializer
    
    ///  JSONを ResponseObjectSerializable protocol のGenericsから生成
    ///
    ///  - parameter response:       apiレスポンス
    ///  - parameter representation: JSONにコンバートしたAnyObject
    ///
    ///  - returns: instance
    public init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.init(representation)
    }
}