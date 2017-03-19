//
//  APIManager.swift
//  GetirBitaksiHackathonSample
//
//  Created by Olgu Sirman on 18/03/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func getElements(with participant : Participant)
}

class APIManager {
    
    class func getElements(email: String,name: String,gsm : String, successHandler : @escaping (_ base : OSBase) -> () ) {
        
        let url = URL(string: "https://getir-bitaksi-hackathon.herokuapp.com/getElements")!
        
        let parameters : Parameters = ["email" : email,
                                       "name" : name,
                                       "gsm" : gsm]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (dataResponse) in
            
            switch dataResponse.result {
                
            case .success(let value as [String : Any]):
                
                if let responseObject = OSBase(JSON: value) {
                    
                    guard let code = responseObject.code else { return }
                    guard let msg = responseObject.msg, msg == "Success" else { return }
                    
                    if code == 0  {
                        successHandler(responseObject)
                    }
                    
                }
                
            case .failure(let error):
                ErrorHandler().handler(error: error)
                
            default: ()
            }
            
        }
        
        
    }
    
}

struct ErrorHandler {
    func handler(error : Error ) {
        
        debugPrint(error)
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                print("Invalid URL: \(url) - \(error.localizedDescription)")
            case .parameterEncodingFailed(let reason):
                print("Parameter encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                print("Multipart encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                print("Response validation failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    print("Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    print("Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("Response status code was unacceptable: \(code)")
                }
            case .responseSerializationFailed(let reason):
                print("Response serialization failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            }
            
            print("Underlying error: \(error.underlyingError)")
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
        } else {
            print("Unknown error: \(error)")
        }
    }
}
