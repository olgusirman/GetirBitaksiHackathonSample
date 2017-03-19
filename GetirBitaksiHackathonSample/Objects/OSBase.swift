//
//  OSBase.swift
//
//  Created by Olgu Sirman on 18/03/2017
//  Copyright (c) Sirman. All rights reserved.
//

import Foundation
import ObjectMapper

class OSBase: Mappable {
    
    private let kOSBaseCodeKey: String = "code"
    private let kOSBaseElementsKey: String = "elements"
    private let kOSBaseMsgKey: String = "msg"
    
    var code: Int?
    var elements: [OSElements]?
    var msg: String?
    
    required init(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map[kOSBaseCodeKey]
        elements <- map[kOSBaseElementsKey]
        msg <- map[kOSBaseMsgKey]
    }
    
}
