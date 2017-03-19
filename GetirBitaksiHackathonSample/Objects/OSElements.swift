//
//  OSElements.swift
//
//  Created by Olgu Sirman on 18/03/2017
//  Copyright (c) Sirman. All rights reserved.
//

import Foundation
import ObjectMapper

enum ElementType : String {
    case circle
    case rectangle
}

class OSElements: Mappable {
    
    private let kOSElementsXPositionKey: String = "xPosition"
    private let kOSElementsHeightKey: String = "height"
    private let kOSElementsRKey: String = "r"
    private let kOSElementsWidthKey: String = "width"
    private let kOSElementsYPositionKey: String = "yPosition"
    private let kOSElementsTypeKey: String = "type"
    private let kOSElementsColorKey: String = "color"
    
    var xPosition: Int?
    var height: Int?
    var r: Int?
    var width: Int?
    var yPosition: Int?
    var type: String?
    var color: String?
    
    required init( map: Map){
        
    }
    
    func mapping(map: Map) {
        xPosition <- map[kOSElementsXPositionKey]
        height <- map[kOSElementsHeightKey]
        r <- map[kOSElementsRKey]
        width <- map[kOSElementsWidthKey]
        yPosition <- map[kOSElementsYPositionKey]
        type <- map[kOSElementsTypeKey]
        color <- map[kOSElementsColorKey]
    }
    
}
