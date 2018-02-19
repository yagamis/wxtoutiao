//
//  Category.swift
//  WxToutiao
//
//  Created by yons on 2017/5/20.
//  Copyright © 2017年 yons. All rights reserved.
//

import Foundation
import Moya

struct CategoryIndexResponse: Codable {
    var status = ""
    var count = 0
    var categories : [Category]!
}

struct Category: Codable {
    var id = 0
    var title = ""
    
}


extension Category {
    /// 获取新闻分类
    static func request(completion: @escaping ([Category]?) -> Void ) {
        
        
        let provider = MoyaProvider<NetworkService>()
        
        
        
        provider.request(.category) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                do {
                    let decoder = JSONDecoder()
                    
                    let catesIndexResponse = try decoder.decode(CategoryIndexResponse.self, from: moyaResponse.data)
                        
                    print("目录json",catesIndexResponse)
                    completion(catesIndexResponse.categories)

                } catch  {
                    print("目录json解析错误:",error)
                }
                
//                let json = try! moyaResponse.mapJSON() as! [String:Any]
//
//                if let jsonResponse = CategoryIndexResponse(JSON: json) {
//
//                    completion(jsonResponse.categories)
//
//                }
                
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
        
    }

}





