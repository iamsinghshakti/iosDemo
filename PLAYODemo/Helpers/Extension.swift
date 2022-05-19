//
//  Extension.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import Foundation
import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

class lazyloadingIMg: UIImageView {
    var imgUrlstring:String?
    func downloadImageFrom(link:String,isTempImage:Bool = false) {
        if link == ""{
            return
        }
        imgUrlstring = link
        guard let url = URL(string: link) else {return}
        
        if let imageFromCache = imageCache.object(forKey: link as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                if isTempImage{
                    let renderImg =  imageFromCache.withRenderingMode(.alwaysTemplate)
                    self.image = renderImg
                }
                else{
                    self.image = imageFromCache
                }
            }
            return
        }
     
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error as Any)
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    if let imgToCache = UIImage(data: data){
                    if self.imgUrlstring == link{
                        imageCache.setObject(imgToCache, forKey: link as AnyObject)
                        if isTempImage{
                            let renderImg =  imgToCache.withRenderingMode(.alwaysTemplate)
                            self.image = renderImg
                        }else{
                            self.image = imgToCache
                        }
                    }
                    }
                }
            }
        }).resume()
    }
}


