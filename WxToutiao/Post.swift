//
//  Post.swift
//  WxToutiao
//
//  Created by yons on 2017/5/26.
//  Copyright © 2017年 yons. All rights reserved.
//
//

import Foundation
import ObjectMapper
import Moya

struct PostIndexResponse: Mappable {
    var status : String!
    var count : Int!
    var posts : [Post]!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        count <- map["count"]
        posts <- map["posts"]
    }
}

struct SubmitResponse: Mappable {
    var status : String!
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
    }
}

struct Comment: Mappable {
    var name: String!
    var content: String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        content <- map["content"]
        name <- map["name"]
    }
}



struct Post: Mappable {
    var id : Int!
    var title : String!
    
    var content : String!
    var url : String!
    var comment_count : Int!
    var comments: [Comment]!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        
        content <- map["content"]
        url <- map["url"]
        comment_count <- map["comment_count"]
        comments <- map["comments"]

    }
}


extension Post {
    /// 获取分类下的文章列表
    static func request(id: Int,completion: @escaping ([Post]?) -> Void ) {
        
        
        let provider = MoyaProvider<NetworkService>()
        
        
        provider.request(.showCateNewsList(id: id)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String:Any]
                
                if let jsonResponse = PostIndexResponse(JSON: json) {
                    completion(jsonResponse.posts)
                }
                
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
                let json = try! moyaResponse.mapJSON() as! [String:Any]
                
                if let jsonResponse = SubmitResponse(JSON: json) {
                    
                    if jsonResponse.status == "ok" {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
                
            case .failure:
                print("网络错误")
                completion(false)
                
            }
        }
        
    }
    
}






