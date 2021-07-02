//
//  UnixDateConverter.swift
//  ProjektManhatann
//
//  Created by Grzegorz Gumieniak on 01/07/2021.
//

import Foundation

struct UnixDateConverter {
    
    
    
    func convertUnixDateToStringDate(from dateInUnix: Int) -> String {
        return getDateInString(from: dateInUnix)
    }
    
    private func getDateInString(from dateInInt: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: createDateInInt(from: dateInInt))
    }
    
    private func createDateInInt(from dateInInt: Int) -> Date {
        return Date(timeIntervalSince1970: createTimeIntervalFromInt(dateInInt))
    }
    
    private func createTimeIntervalFromInt(_ dateInInt: Int) -> TimeInterval {
        return TimeInterval(dateInInt)
    }
}
