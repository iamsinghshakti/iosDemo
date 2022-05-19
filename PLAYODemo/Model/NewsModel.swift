//
//  NewsModel.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import Foundation

struct NewsModel:Codable{
    var status:String?
    var totalResults:Int?
    var articles:[NewsArticlesModel]?
}
struct NewsArticlesModel:Codable{
    var source:ArticleSourceModel?
    var author,content,description,publishedAt,title,urlToImage,url:String?
}
struct ArticleSourceModel:Codable{
    var id,name:String?
}
