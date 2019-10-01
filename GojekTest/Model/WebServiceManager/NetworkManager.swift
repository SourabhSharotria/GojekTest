//
//  NetworkManager.swift
//  GojekTest
//
//  Created by Sourav on 27/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation
import SystemConfiguration
import CoreServices
import UIKit

class NetworkManager
{
    var BaseUrl:String = "http://gojek-contacts-app.herokuapp.com"
    
    static let shareInstance = NetworkManager()
    private init(){}
    
    enum JSONError: String, Error{
        case NoData = "No data"
        case ConversionFailed = "Unable to parse json"
    }
    enum ReqestType:String{
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    func callData(requestType: ReqestType ,params: [String:Any]?, path:String, completion: @escaping (_ result: Data) -> Void){
        if isInternetAvailable() {
            let urlPath = BaseUrl + path
            guard let endpoint = NSURL(string: urlPath)
                else {
                    Helper.showAlert(title: "Error", subtitle:"Error creating endpoint")
                    return
            }
            var request = URLRequest(url:endpoint as URL)
            
            if (params != nil) {
                
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = requestType.rawValue
            
            if (requestType == .post || requestType == .put || requestType == .delete) && (params != nil) {
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject:params!, options:[.prettyPrinted])
                    request.httpBody = jsonData
                    
                } catch {
                }
            }
            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
                do{
                    guard let dataResponse = data else{
                        throw JSONError.NoData
                    }
                    
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                    
                    if let json = (jsonResponse as? [String:Any]), let error = json["errors"] as? [String] {
                        Helper.showAlert(title: "Error", subtitle: error.last ?? "Something went wrong")
                        return
                    }
                    
                    completion(dataResponse)
                }
                catch let error as JSONError{
                    Helper.showAlert(title: "Error", subtitle: error.localizedDescription)
                    return
                }
                catch let error as NSError {
                    Helper.showAlert(title: "Error", subtitle: error.localizedDescription)
                    return
                }
            }.resume()
        }else{
            Helper.showAlert(title: "Error", subtitle: "Please check your internet connection")
            return
        }
    }
    
    func uploadFileData(requestType: ReqestType, params: [String:Any]?, path:String, filePath:String, completion: @escaping (_ result: Data) -> Void) {

        let boundary = generateBoundaryString()

        let urlPath = BaseUrl + path
        guard let endpoint = NSURL(string: urlPath)
            else {
                Helper.showAlert(title: "Error", subtitle:"Error creating endpoint")
                return
        }
        var request = URLRequest(url:endpoint as URL)
        request.httpMethod = requestType.rawValue
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        do{            
            let body = try createBody(with: params, filePathKey: "profile_pic", paths: [filePath], boundary: boundary)
            
            request.httpBody = body
            
        } catch let parsingError {
            print("Error", parsingError)
        }

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            do{
                guard let dataResponse = data else{
                    throw JSONError.NoData
                }
                
                let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: [])
                
                if let json = (jsonResponse as? [String:Any]), let error = json["errors"] as? [String] {
                    Helper.showAlert(title: "Error", subtitle: error.last ?? "Something went wrong")
                    return
                }
                
                completion(dataResponse)
            }
            catch let error as JSONError{
                Helper.showAlert(title: "Error", subtitle: error.localizedDescription)
                return
            }
            catch let error as NSError {
                Helper.showAlert(title: "Error", subtitle: error.localizedDescription)
                return
            }
            }.resume()
    }
    
    private func createBody(with parameters: [String: Any]?, filePathKey: String, paths: [String], boundary: String) throws -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key,value) in parameters! {
              if value is Dictionary<String, Any> {
                for (objKey,ObjValue) in value as! Dictionary<String, Any> {
                  body.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                  body.append("Content-Disposition: form-data; name=\"\(key)[\(objKey)]\"\r\n\r\n\(ObjValue)".data(using: String.Encoding.utf8)!)
                }
              } else {
                body.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
              }
            }
        }
        
        body.append("\r\n")

        for path in paths {
            
            let url = URL(fileURLWithPath: path)
            let filename = url.lastPathComponent
            
            do {
                let data = try Data(contentsOf: url)
                let mimetype = mimeType(for: path)

                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"contact[\(filePathKey)]\"; filename=\"\(filename)\"\r\n")
                body.append("Content-Type: \(mimetype)\r\n\r\n")
                body.append(data)
                body.append("\r\n")
            } catch  {
            }
        }

        body.append("--\(boundary)--\r\n")
        return body
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    private func mimeType(for path: String) -> String {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension

        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    private func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
