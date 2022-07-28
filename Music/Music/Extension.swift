//
//  Extension.swift
//  Music
//
//  Created by QuangHo on 13/07/2022.
//

import Foundation
import SwiftUI
extension Int {
    func formatToMins() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional

        let formattedString = formatter.string(from: TimeInterval(self))!
        if self < 60 {
            return ""
        }
        return formattedString
    }
    
    func formatTimerCoundownForMins() -> String {
        let dateFormat = DateComponentsFormatter()
        dateFormat.unitsStyle = .positional
        dateFormat.allowedUnits = [.minute, .second]
        dateFormat.zeroFormattingBehavior = [.pad]
        let format = dateFormat.string(from: TimeInterval(self))!
        return format
    }
    
}

extension Color {
   static func hex(hex:String) -> Color {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return .gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return Color(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0
        )
    }
}
