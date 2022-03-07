//
//  ReportViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 26.12.2021.
//

import Foundation
import Charts

class ReportViewModel: ReportViewControllerViewModelType {
    
    let data = ReportPersistance.shared
    
    var report = [String: [String]]()
    var dates: [Dates] = []
    
    var selectedIndex = Int()
    
    let titles = ["Расход", "Остаток"]
        
    var incomeText = Dynamic("0 ₽")
    var consumptionText = Dynamic("0 ₽")
    var totalText = Dynamic("0 ₽")
    
//MARK: Drow PieChartView
    
    func drow(view: PieChartView) {
        var yVals = [PieChartDataEntry]()
        view.usePercentValuesEnabled = true
        view.legend.maxSizePercent = 1
        view.holeRadiusPercent = 0
        view.transparentCircleRadiusPercent = 0
        view.entryLabelColor = .black
        view.entryLabelFont = .systemFont(ofSize: 12)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1.0
    
        let consumption = consumptionText.value.removingWhitespacesAndNewlines
        let consumptionDouble = (consumption as NSString).doubleValue
        let total = totalText.value.removingWhitespacesAndNewlines
        var totalDouble = (total as NSString).doubleValue
        if totalDouble <= 0 {
            totalDouble = 0
        }
        
        yVals.append(PieChartDataEntry.init(value: consumptionDouble, label: titles[0]))
        yVals.append(PieChartDataEntry.init(value: totalDouble, label: titles[1]))
        
        let dataSet = PieChartDataSet.init(entries: yVals, label: "")
        dataSet.colors = [.systemYellow, .systemCyan]
        dataSet.xValuePosition = .insideSlice
        dataSet.yValuePosition = .outsideSlice
        
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.9
        dataSet.valueLinePart2Length = 0.5
        dataSet.valueLineWidth = 1
        dataSet.valueLineColor = UIColor.lightGray
        
        let data = PieChartData.init(dataSets: [dataSet])
        data.setValueFont(UIFont.systemFont(ofSize: 10.0))
        data.setValueTextColor(UIColor.black)
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        view.data = data
        view.animate(yAxisDuration: 0.5, easingOption: .linear)
    }
 
//MARK: Create dictionary from dates
    
    func createDates() {
        dates.removeAll()
        report = [:]
        incomeText.value = "0 ₽"
        consumptionText.value = "0 ₽"
        totalText.value = "0 ₽"
        for i in data.getItemsIncome() {
            report[i.incomeDate] = [i.incomeSum, "0"]
            for s in data.getItemsConsumption() {
                if i.incomeDate == s.consumptionDate {
                    report[i.incomeDate] = [i.incomeSum, s.consumptionSum]
                }
            }
            let date = Dates(date: i.incomeDate)
            dates.append(date)
        }
        dates.sort{ compareDates($0.date, $1.date) }
        
    }

    func compareDates(_ first: String, _ second: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.date(from: first)! > formatter.date(from: second)!
    }
    
    func addValues() {
        for (key, value) in report {
            if key == dates[selectedIndex].date {
                let incomeSum = value[0].removingWhitespacesAndNewlines
                let incomeSumTotal = (incomeSum as NSString).integerValue
                incomeText.value = "\(incomeSumTotal) ₽"
                let consumptionSum = value[1].removingWhitespacesAndNewlines
                let consumptionSumTotal = (consumptionSum as NSString).integerValue
                let total = incomeSumTotal - consumptionSumTotal
                consumptionText.value = "\(consumptionSumTotal) ₽"
                totalText.value = "\(total) ₽"
        }
    }
}
    
//MARK: UICollectionViewDelegate
    
    func collectionViewNumberOfItemsInSection() -> Int {
        return dates.count
    }
    
    func collectionViewCellForItemAt(_ indexPath: IndexPath) -> ReportCollectionViewCellViewModelType? {
        let date = dates[indexPath.row]
        return ReportCollectionViewCellViewModel(date: date)
    }
    
    func collectionViewMinimumLineSpacingForSectionAt() -> CGFloat {
        return 10
    }
    
    func collectionViewDidSelectItemAt(_ indexPath: IndexPath) {
        selectedIndex = indexPath.row
        addValues()
    }
}
