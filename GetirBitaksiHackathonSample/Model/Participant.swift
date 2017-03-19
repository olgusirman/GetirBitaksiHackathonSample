//
//  Participant.swift
//  GetirBitaksiHackathonSample
//
//  Created by Olgu Sirman on 19/03/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation

struct Participant {
    var name : String
    var email : String
    var gsm : String
    
    init(name : String, email: String, gsm : String) {
        self.name = name
        self.email = email
        self.gsm = gsm
    }
    
}
