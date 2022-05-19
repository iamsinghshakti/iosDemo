//
//  NewsVM.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import Foundation
class NewsVM{
    var newsArticleList:[NewsArticlesModel] = []
    func getNewsData(completion:@escaping (Bool)->Void){
        let req = RequestGenerator.getNewsDataRequest()
        
        ServiceHandler.executeWithUrlSession(req) { data, json, error in
            if error == nil{
                do{
                    let res = try JSONDecoder().decode(NewsModel.self, from: data!)
                    if let dta = res.articles{
                        self.newsArticleList.removeAll()
                        self.newsArticleList.append(contentsOf: dta)
                       
                    }else{
                        self.newsArticleList.removeAll()
                    }
                    completion(true)
                }catch{
                    completion(false)
                    print(error)
                }
            }else{
                completion(false)
                print(error as Any)
            }
        }
    }
    
    
}
