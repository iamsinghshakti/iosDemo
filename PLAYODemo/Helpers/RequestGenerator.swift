//
//  RequestGenerator.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import Foundation

class RequestGenerator{
    static func getNewsDataRequest()->RequestData{
        let requestData = RequestData()
        requestData!.baseURL = "https://newsapi.org"
        requestData?.webServiceURL = "/v2/top-headlines?sources=techcrunch&apiKey=9f28ec71eb044a7ab4f582f1b3103d9f"
        requestData?.requestType = "GET"
        requestData?.headerParameters = nil
        requestData?.postData = nil
        return requestData!
    }
}

