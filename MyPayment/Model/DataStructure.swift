//
//  DataStructure.swift
//  MyPayment
//
//  Created by Антон Дубино on 10.12.2021.
//

import Foundation

class DataStructure {
    
    class Record : Comparable {
        
        let calendar: Calendar = {
        var calendar = Calendar.autoupdatingCurrent
        calendar.locale = Locale(identifier: "ru_RU")
            return calendar
        }()
            
        var date: Date
        init(date: Date) {
            self.date = date
        }
        
        static func == (lhs: Record, rhs: Record) -> Bool {
            lhs.date == rhs.date
        }
        static func < (lhs: Record, rhs: Record) -> Bool {
            lhs.date > rhs.date
        }
    }
        
    class Section : Record {
            
        private let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "LLLL yyyy"
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter
        }()
            
        var title: String {
            formatter.string(from: date)
        }
        var items = [SectionItem]()
            
        func addRecord(_ record: SectionItem) {
            items.append(record)
        }
    }
        
    class SectionItem : Record {
            
        private let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter
        }()
            
        var year: Int {
            calendar.component(.year, from: date)
        }
        var month: Int {
            calendar.component(.month, from: date)
        }
        var title: String {
            formatter.string(from: date)
        }
        var time: Int {
            calendar.component(.second, from: date)
        }
    }
}
