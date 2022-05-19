//
//  Apputility.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import Foundation
import UIKit
class Apputility{
    static let activityView:UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)

    static func showLoader(pView:UIView){
        pView.isUserInteractionEnabled = false

        DispatchQueue.main.async {
            activityView.color = UIColor.darkGray
            activityView.center = pView.center
            activityView.startAnimating()
            activityView.tag = 1000
            pView.addSubview(activityView)
        }
    }
    
    //  Hide loader :-
    static func hideLoader(pView:UIView){
        pView.isUserInteractionEnabled = true
        DispatchQueue.main.async {
            activityView.stopAnimating()
            if let view = activityView.viewWithTag(1000){
                view.removeFromSuperview()
            }
        }
    }
}
