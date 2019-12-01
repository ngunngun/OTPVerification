//
//  String+Sugar.swift
//  OTPVerify
//
//  Created by Kirameki on 1/12/2562 BE.
//  Copyright © 2562 ngunngun. All rights reserved.
//

import Foundation

extension String {
    
    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    mutating func replace(_ originalString:String, with newString:String) {
        self = self.replacingOccurrences(of: originalString, with: newString)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
}
