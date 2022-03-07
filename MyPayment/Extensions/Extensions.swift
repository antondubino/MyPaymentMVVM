//
//  Extensions.swift
//  MyPayment
//
//  Created by Антон Дубино on 10.12.2021.
//

import Foundation
import UIKit

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension String {
    var removingWhitespacesAndNewlines: String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
}

extension UIColor {
     func toString() -> String {
          let colorRef = self.cgColor
          return CIColor(cgColor: colorRef).stringRepresentation
     }
 }

extension Date {
    var seconds: Int {
        return Calendar.current.component(.second, from: self)
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
  }
}

extension UITableView {
    func lastIndexpath() -> IndexPath {
        let section = self.numberOfSections - 1//max(numberOfSections - 1, 0)
        let row = self.numberOfRows(inSection: section) - 1

        return IndexPath(row: row, section: section)
    }
}
