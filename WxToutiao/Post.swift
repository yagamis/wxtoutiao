//
//  Post.swift
//  WxToutiao
//
//  Created by yons on 2017/5/26.
//  Copyright © 2017年 yons. All rights reserved.
//
//

import Foundation
import Moya

struct PostIndexResponse: Codable {
    var status = ""
    var count : Int?
    var posts : [Post]!
}

struct SubmitResponse: Codable {
    var status = ""
}

struct Comment: Codable {
    var name = ""
    var content = ""

}

struct Post: Codable {
    var id = 0
    var title = ""
    
    var content = ""
    var url = ""
    var comment_count = 0
    var comments: [Comment]!
}


extension Post {
    /// 获取分类下的文章列表
    static func request(id: Int,completion: @escaping ([Post]?) -> Void ) {
        
        
        let provider = MoyaProvider<NetworkService>()
        
        
        provider.request(.showCateNewsList(id: id)) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                do {
                    let decoder = JSONDecoder()
                    
                    let postIndexResponse = try decoder.decode(PostIndexResponse.self, from: moyaResponse.data)
                    print("文章列表json:", postIndexResponse)
                    completion(postIndexResponse.posts)
                } catch  {
                    print("文章列表json解析错误：",error)
                }
                
//                let json = try! moyaResponse.mapJSON() as! [String:Any]
//
//                if let jsonResponse = PostIndexResponse(JSON: json) {
//                    completion(jsonResponse.posts)
//                }
                
            case .failure:
                print("网络错误")
                completion(nil)
                
            }
        }
        
    }
    
    /// 发表文章的评论
    static func submitComment(postId: Int, name: String, email: String, content: String,completion: @escaping (Bool) -> Void ) {
        let provider = MoyaProvider<NetworkService>()
        
        provider.request(.submitComment(postId: postId, name: name, email: email, content: content)) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                do {
                    let decoder = JSONDecoder()
                    
                    let submitResponse = try decoder.decode(SubmitResponse.self, from: moyaResponse.data)
                    print("提交评论json:", submitResponse)
                    
                    if submitResponse.status == "ok" {
                        completion(true)
                    } else {
                        completion(false)
                    }
                    
                   
                } catch  {
                    print("json解析错误",error)
                }
                
                
                
            case .failure:
                print("网络错误")
                completion(false)
                
            }
        }
        
    }
    
}






