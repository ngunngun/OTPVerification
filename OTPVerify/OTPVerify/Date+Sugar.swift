//
//  Date+Sugar.swift
//  OTPVerify
//
//  Created by Kirameki on 1/12/2562 BE.
//  Copyright © 2562 ngunngun. All rights reserved.
//

import Foundation

extension Date {
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}
