//
//  ReportViewControllerViewModelType.swift
//  MyPayment
//
//  Created by Антон Дубино on 26.12.2021.
//

import Foundation
import Charts

protocol ReportViewControllerViewModelType {
    var data: ReportPersistance { get }
    var report: [String: [String]] { get set }
    var dates: [Dates] { get set }
    var selectedIndex: Int { get set }
    var titles: [String] { get }
//    var value1: Int { get set }
//    var value2: Int { get set }
    var incomeText: Dynamic<String> { get set }
    var consumptionText: Dynamic<String> { get set }
    var totalText: Dynamic<String> { get set }
    
    func drow(view: PieChartView)
    func createDates()
    func compareDates(_ first: String, _ second: String) -> Bool
    func addValues()
//    func changeValues()
    
    func collectionViewNumberOfItemsInSection() -> Int
    func collectionViewCellForItemAt(_ indexPath: IndexPath) -> ReportCollectionViewCellViewModelType?
    func collectionViewMinimumLineSpacingForSectionAt() -> CGFloat
    func collectionViewDidSelectItemAt(_ indexPath: IndexPath)
}
