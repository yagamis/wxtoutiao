//
//  Category.swift
//  WxToutiao
//
//  Created by yons on 2017/5/20.
//  Copyright © 2017年 yons. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

struct CategoryIndexResponse: Mappable {
    var status : String!
    var count : Int!
    var categories : [Category]!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        count <- map["count"]
        categories <- map["categories"]
    }
}

struct Category: Mappable {
    var id : Int!
    var title : String!
    var count : Int!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        count <- map["post_count"]
    }
}


extension Category {
    /// 获取新闻分类
    static func request(completion: @escaping ([Category]?) -> Void ) {
        
        
        let provider = MoyaProvider<NetworkService>()
        
        
        provider.request(.category) { (result) in
            switch result {
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String:Any]
                
                if let jsonResponse = CategoryIndexResponse(JSON: json) {

                    completion(jsonResponse.categories)

                }
                
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
        
    }

}





