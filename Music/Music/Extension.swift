//
//  Extension.swift
//  Music
//
//  Created by QuangHo on 13/07/2022.
//

import Foundation
extension Int {
    func formatToMins() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional

        let formattedString = formatter.string(from: TimeInterval(self))!
        print(formattedString)
        return formattedString
    }
    
}
