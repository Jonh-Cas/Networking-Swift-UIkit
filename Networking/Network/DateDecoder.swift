//
//  DateDecoder.swift
//  Networking
//
//  Created by Jonathan Casillas on 03/10/23.
//

import Foundation

final class DateDecoder: JSONDecoder {
    
    let dateFormater = DateFormatter()
    
    override init() {
        super.init()
        //2020-10-10T03:50:06.151+05:30
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateDecodingStrategy = .formatted(dateFormater)
    }
    
}
