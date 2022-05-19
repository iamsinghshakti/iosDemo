//
//  ServiceHandler.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import Foundation
class ServiceHandler{
    static func executeWithUrlSession(_ requestData: RequestData, completion: @escaping (Data?,Any?,String?) -> Void){
        let strUrl = String(format: "%@%@", requestData.baseURL!, requestData.webServiceURL ?? "")
        guard let url = URL(string: strUrl) else {return}
        do{
            print(url)
            var request =  URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = requestData.headerParameters
            
            if let parameter = requestData.postData{
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
              } catch let error {
                print(error.localizedDescription)
                
              }
            }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {
                    print("error", error ?? "Unknown error")
                        completion(nil,nil,error.debugDescription )
                        return
                }

                guard (200 ... 299) ~= response.statusCode else {                    
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    completion(nil,nil,"\(response.statusCode)" )
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString ?? "")")
                completion(data,responseString,nil)
            }

            task.resume()
        }catch{
            print(error)
        }
    
    }
}
class RequestData {
    
    public var postData : Dictionary<String, Any>?
    public var baseURL : String?
    public var webServiceURL : String?
    public var requestType : String?
    public var responseData : Any?
    public var error : String?
    public var headerParameters : [String: String]? = ["ContentType":"application/json"]
    
    required public init?() {
        
    }

}
func getMethodType(requestData : RequestData) -> HTTPMethod{
     let temp = requestData.requestType;
     switch temp {
     case "REQUEST_TYPE_POST":
         return .post;
     case "REQUEST_TYPE_GET":
         return .get;
     case "REQUEST_TYPE_PUT":
         return .put;
     default:
         return .post;
     }
 }
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
