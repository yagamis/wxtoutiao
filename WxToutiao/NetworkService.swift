//
//  NetworkService.swift
//  WxToutiao
//
//  Created by yons on 2017/5/20.
//  Copyright © 2017年 yons. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case category
    case showCateNewsList(id: Int)
    case submitComment(postId: Int, name: String, email: String, content: String)
}

extension NetworkService: TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    

    
    
    
    var baseURL: URL {
        let baseUrl = "http://blog.xiaoboswift.com/api"
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .category:
            return "/get_category_index"
        case .showCateNewsList:
            return "/get_category_posts"
        case .submitComment:
            return "/respond/submit_comment"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .category, .showCateNewsList, .submitComment:
            return .get
        }
    }
    
    
    var sampleData: Data {
        switch self {
        case .category:
            return "category test data".utf8Encoded
        case .showCateNewsList(let id):
            return "newslist id is \(id)".utf8Encoded
       case .submitComment(let postId, let name, let email, let content):
            return "\(postId),\(name),\(email),\(content)".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .category:
            return .requestPlain
        case .showCateNewsList(let id):
            return .requestParameters(parameters: ["id" : id], encoding: URLEncoding.queryString)
        case .submitComment(let postId, let name, let email, let content):
            return .requestParameters(parameters: ["post_id": postId, "name": name, "email": email, "content": content], encoding: URLEncoding.queryString)
        }
    }
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
