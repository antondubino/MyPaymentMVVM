//
//  ReportCollectionViewCellViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 26.12.2021.
//

import Foundation

class ReportCollectionViewCellViewModel: ReportCollectionViewCellViewModelType {
    
    private var date: Dates
    
    var name: String {
        return date.date
    }
    
    init(date: Dates) {
        self.date = date
    }
}
