//
//  html2String.swift
//  WxToutiao
//
//  Created by yons on 2017/6/2.
//  Copyright © 2017年 yons. All rights reserved.
//

extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch  {
            print(error)
            return nil
        }
    }
    
    var html2String:String {
        return html2AttributedString?.string ?? ""
    }
}
