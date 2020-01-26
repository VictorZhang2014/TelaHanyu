//
//  String+Extension.swift
//  TelaHanyu
//
//  Created by victor on 1/27/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

extension String {
    
    func encodeUrl() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
}
