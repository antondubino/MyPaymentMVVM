//
//  CalculateViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 20.12.2021.
//

import Foundation

class CalculateViewModel: CalculateViewControllerViewModelType {
    
    var selectedIndexPathItem: IndexPath?
    
    var result: Int = 0
    var totalT: Int = 0
    var initialT: Int = 0
    var initialTP: Double = 0
    var termT:Int = 0
    var bidT: Double = 0
    
    var paymentT: String = "0"
    var creditAmountT: String = "0"
    var interestT: String = "0"
    var creditAmountWithPercentT: String = "0"
    
    var toMonths = false
    var toRouble = false
    
    var amtTotalCost: Int = 0
    var amtInitial: Int = 0
    var amtTerm: Int = 0
    var amtBid: Int = 0
    
    var amountTotalCost: String? = "0"
    var amountInitial: String? = "0"
    var amountTerm: String? = "0"
    var amountBid: String? = "0"
    
    var data = ConsumptionPersistance.shared
    
    let emoji = Emoji.allEmoji
    var images: [Image] = []
    var image = "none"
    
    var totalCostText = Dynamic("")
    var initialText = Dynamic("")
    var termText = Dynamic("")
    var bidText = Dynamic("")
    var popUpNameTextFieldText = Dynamic("")
    var yearsButton = Dynamic(false)
    var monthsButton = Dynamic(true)
    var saveButton = Dynamic(false)
    var paymentText = Dynamic("0 ₽")
    var creditAmountText = Dynamic("0 ₽")
    var creditAmountWithPercentText = Dynamic("0 ₽")
    var interestText = Dynamic("0 ₽")
    var termPlaceholder = Dynamic("0 лет")
    var initialPlaceholder = Dynamic("0 %")
    
    var visualEffectHidden = Dynamic(true)
    var popUpSaveButtonEnabled = Dynamic(false)
    
//MARK: Add image in images
    
    func createImages() {
        for i in emoji {
            let image = Image(name: i)
            images.append(image)
        }
    }
    
//MARK: Remove collectionView Index
    
    func removeIndex() {
        if selectedIndexPathItem?.count != 0 {
        selectedIndexPathItem?.removeLast()
        image = "none"
        }
    }
    
//MARK: Button actions
    
    func saveButtonAction() {
        visualEffectHidden.value = false
    }
    
//MARK: Calculate results
    
    func culcResultYears() {
        if result <= 0 { result = 0 }
        paymentT = String(result.formattedWithSeparator)
        if toRouble == false {
           initialT = Int(Double(totalT) / 100 * initialTP)
        }
        var creditAmountFunc = totalT - initialT
        if creditAmountFunc <= 0 { creditAmountFunc = 0 }
        creditAmountT = String(Int(creditAmountFunc).formattedWithSeparator)
        var interestFunc = result * (termT * 12) - creditAmountFunc
        if interestFunc <= 0 { interestFunc = 0 }
        interestT = String(interestFunc.formattedWithSeparator)
        var creditAmountWithPercentFunc = creditAmountFunc + interestFunc
        if creditAmountWithPercentFunc <= 0 || interestFunc == 0 {creditAmountWithPercentFunc = 0 }
        creditAmountWithPercentT = String(creditAmountWithPercentFunc.formattedWithSeparator)
        if bidT == 0 {
            result = Int(Calculations.shared.mortgageCalculateYearsInstallment(totalCost: totalT, initial: initialT, term: termT))
            creditAmountWithPercentT = "\(creditAmountT)"
            interestT = "0"
        } else {
            result = Int(Calculations.shared.mortgageCalculateYears(totalCost:totalT, initial: initialT, term: termT, bid: bidT))
        }
    }
    
    func culcResultMonths() {
        if result <= 0 { result = 0 }
        paymentT = String(result.formattedWithSeparator)
        if toRouble == false {
           initialT = Int(Double(totalT) / 100 * initialTP)
        }
        var creditAmountFunc = totalT - initialT
        if creditAmountFunc <= 0 { creditAmountFunc = 0 }
        creditAmountT = String(creditAmountFunc.formattedWithSeparator)
        var interestFunc = result * termT - creditAmountFunc
        if interestFunc <= 0 { interestFunc = 0 }
        interestT = String(interestFunc.formattedWithSeparator)
        var creditAmountWithPercentFunc = creditAmountFunc + interestFunc
        if creditAmountWithPercentFunc <= 0 || interestFunc == 0 {creditAmountWithPercentFunc = 0 }
        creditAmountWithPercentT = String(creditAmountWithPercentFunc.formattedWithSeparator)
        if bidT == 0 {
            result = Int(Calculations.shared.mortgageCalculateMonthsInstallment(totalCost: totalT, initial: initialT, term: termT))
            creditAmountWithPercentT = "\(creditAmountT)"
            interestT = "0"
        } else {
        result = Int(Calculations.shared.mortgageCalculateMonths(totalCost:totalT, initial: initialT, term: termT, bid: bidT))
        }
    }
    
    func yearsOrMonths() {
        yearsButton.value == false ? culcResultYears() :culcResultMonths()
        paymentText.value = paymentT + " ₽"
        creditAmountText.value = creditAmountT + " ₽"
        creditAmountWithPercentText.value = creditAmountWithPercentT + " ₽"
        interestText.value = interestT + " ₽"
        if paymentText.value == "0 ₽" {
            saveButton.value = false
        } else {
            saveButton.value = true
        }
    }

//MARK: NumberFormatter for textFields
    
    func updateAmountTotalCost() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amtTotalCost))
    }
    
    func updateAmountInitial() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amtInitial))
    }
    
    func updateAmountInitialPercent() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "%"
        let amount = Double(amtInitial / 100) + Double(amtInitial % 100) / 100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    func updateTermYears() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "лет"
        return formatter.string(from: NSNumber(value: amtTerm))
    }
    
    func updateTermMonths() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "месяцев"
        return formatter.string(from: NSNumber(value: amtTerm))
    }
    
    func updateBid() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "%"
        let amount = Double(amtBid / 100) + Double(amtBid % 100) / 100
        return formatter.string(from: NSNumber(value: amount))
    }

//MARK: Button actions
    
    func popUpSave() {
        visualEffectHidden.value = true
        popUpNameTextFieldText.value = ""
        totalT = 0
        initialT = 0
        termT = 0
        bidT = 0
        amtTotalCost = 0
        amtInitial = 0
        amtTerm = 0
        amtBid = 0
        totalCostText.value = ""
        initialText.value = ""
        termText.value = ""
        bidText.value = ""
        yearsOrMonths()
        removeIndex()
    }
    
    func popUpCancel() {
        visualEffectHidden.value = true
        popUpNameTextFieldText.value = ""
        removeIndex()
    }
    
    func toMonthsAction() {
        toMonths = true
        amtTerm = amtTerm * 12
        termPlaceholder.value = updateTermMonths() ?? ""
        if termText.value != "" { termText.value = updateTermMonths() ?? "" }
        monthsButton.value = false
        yearsButton.value = true
    }
    
    func toYearsAction() {
        toMonths = false
        amtTerm = amtTerm / 12
        termPlaceholder.value = updateTermYears() ?? ""
        if termText.value != "" { termText.value = updateTermYears() ?? ""}
        yearsButton.value = false
        monthsButton.value = true
    }
    
    func toRoubleAction() {
        toRouble = true
        amtInitial = initialT
        yearsOrMonths()
        initialPlaceholder.value = updateAmountInitial() ?? ""
        if initialText.value != "" { initialText.value = updateAmountInitial() ?? "" }
    }
    
    func toPercentAction() {
        toRouble = false
        amtInitial = 0
        initialTP = 0
        yearsOrMonths()
        initialPlaceholder.value = updateAmountInitialPercent() ?? ""
        if initialText.value != "" { initialText.value = updateAmountInitialPercent() ?? ""}
    }
    
//MARK: Formatted amount for textFields
    
// amountTotal
    
    func amountTotalCostPlus(str: String) {
        if let digit = Int(str) {
            amtTotalCost = amtTotalCost * 10 + digit
            totalCostText.value = updateAmountTotalCost() ?? ""
            amountTotalCost = updateAmountTotalCost()
            let text = amountTotalCost!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            totalT = total
        }
        yearsOrMonths()
    }
    
    func amountTotalCostMinus(str: String) {
        if str == "" {
            amtTotalCost = amtTotalCost / 10
            totalCostText.value = (amtTotalCost == 0 ? "" :updateAmountTotalCost()) ?? ""
            amountTotalCost = updateAmountTotalCost()
            let text = amountTotalCost!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            totalT = total
        }
        yearsOrMonths()
    }
    
// amountInitial
    
    func amountInitialPlus(str: String) {
        if let digit = Int(str) {
            amtInitial = amtInitial * 10 + digit
            initialText.value = updateAmountInitial() ?? ""
            amountInitial = updateAmountInitial()
            let text = amountInitial!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            initialT = total
        }
        yearsOrMonths()
    }
    
    func amountInitialMinus(str: String) {
        if str == "" {
            amtInitial = amtInitial / 10
            initialText.value = amtInitial == 0 ? "" : updateAmountInitial() ?? ""
            amountInitial = updateAmountInitial()
            let text = amountInitial!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            initialT = total
            }
        yearsOrMonths()
    }
    
    func amountInitialPercentPlus(str: String) {
        if let digit = Int(str) {
            amtInitial = amtInitial * 10 + digit
            initialText.value = updateAmountInitialPercent() ?? ""
            amountInitial = updateAmountInitialPercent()
            var text = amountInitial!.removingWhitespacesAndNewlines
            text.removeLast()
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            let double = formatter.number(from: text)
            initialTP = Double(truncating: double!)
        }
        yearsOrMonths()
    }
    
    func amountInitialPercentMinus(str: String) {
        if str == "" {
            amtInitial = amtInitial / 10
            initialText.value = amtInitial == 0 ? "" : updateAmountInitialPercent() ?? ""
            amountInitial = updateAmountInitialPercent()
            var text = amountInitial!.removingWhitespacesAndNewlines
            text.removeLast()
            let total = (text as NSString).doubleValue
            initialTP = total
            }
        yearsOrMonths()
    }
    
// amountTerm
    
    func amountTermYearsPlus(str: String) {
        if let digit = Int(str) {
            amtTerm = amtTerm * 10 + digit
            termText.value = updateTermYears() ?? ""
            amountTerm = updateTermYears()
            let text = amountTerm!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            termT = total
            }
        yearsOrMonths()
    }
    
    func amountTermYearsMinus(str: String) {
        if str == "" {
            amtTerm = amtTerm / 10
            termText.value = amtTerm == 0 ? "" : updateTermYears() ?? ""
            amountTerm = updateTermYears()
            let text = amountTerm!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            termT = total
        }
        yearsOrMonths()
    }
    
    func amountTermMonthsPlus(str: String) {
        if let digit = Int(str) {
            amtTerm = amtTerm * 10 + digit
            termText.value = updateTermMonths() ?? ""
            amountTerm = updateTermMonths()
            let text = amountTerm!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            termT = total
        }
        yearsOrMonths()
    }
    
    func amountTermMonthsMinus(str: String) {
        if str == "" {
            amtTerm = amtTerm / 10
            termText.value = amtTerm == 0 ? "" : updateTermMonths() ?? ""
            amountTerm = updateTermMonths()
            let text = amountTerm!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            termT = total
            }
        yearsOrMonths()
    }
    
// amountBid
    
    func amountBidPlus(str: String) {
        if let digit = Int(str) {
            amtBid = amtBid * 10 + digit
            bidText.value = updateBid() ?? ""
            amountBid = updateBid()
            var text = amountBid!.removingWhitespacesAndNewlines
            text.removeLast()
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            let double = formatter.number(from: text)
            bidT = Double(truncating: double!)
        }
        yearsOrMonths()
    }
    
    func amountBidMinus(str: String) {
        if str == "" {
            amtBid = amtBid / 10
            bidText.value = amtBid == 0 ? "" : updateBid() ?? ""
            amountBid = updateBid()
            var text = amountBid!.removingWhitespacesAndNewlines
            text.removeLast()
            let total = (text as NSString).doubleValue
            bidT = total
            }
        yearsOrMonths()
    }
    
//MARK: UITextFieldDelegate
    
    func amountTotalCost(string: String) {
        amountTotalCostPlus(str: string)
        amountTotalCostMinus(str: string)
        if totalCostText.value.count == 15 {
            totalCostText.value = "0 ₽"
            amtTotalCost = 0
            amountTotalCost = "0"
            amountTotalCostPlus(str: string)
            amountTotalCostMinus(str: string)
        }
        yearsOrMonths()
    }
    
    func amountInitial(string: String) {
        if toRouble == true {
        amountInitialPlus(str: string)
        amountInitialMinus(str: string)
        if initialText.value.count == 15 {
            initialText.value = "0 ₽"
            amtInitial = 0
            amountInitial = "0"
            amountInitialPlus(str: string)
            amountInitialMinus(str: string)
        }
        yearsOrMonths()
        } else {
            amountInitialPercentPlus(str: string)
            amountInitialPercentMinus(str: string)
            if initialText.value.count > 8 {
                initialText.value = "0 %"
                amtInitial = 0
                amountInitial = "0"
                amountInitialPercentPlus(str: string)
                amountInitialPercentMinus(str: string)
            }
            yearsOrMonths()
        }
        yearsOrMonths()
    }
    
    func amountTerm(string: String) {
        if toMonths == false {
            amountTermYearsPlus(str: string)
            amountTermYearsMinus(str: string)
            if termText.value.count > 7 {
                termText.value = "0 лет"
                amtTerm = 0
                amountTerm = "0"
                amountTermYearsPlus(str: string)
                amountTermYearsMinus(str: string)
            }
            yearsOrMonths()
        } else {
            amountTermMonthsPlus(str: string)
            amountTermMonthsMinus(str: string)
            if termText.value.count > 13 {
                termText.value = "0 месяцев"
                amtTerm = 0
                amountTerm = "0"
                amountTermMonthsPlus(str: string)
                amountTermMonthsMinus(str: string)
            }
            yearsOrMonths()
        }
        yearsOrMonths()
    }
    
    func amountBid(string: String) {
        amountBidPlus(str: string)
        amountBidMinus(str: string)
        if bidText.value.count > 8 {
            bidText.value = ""
            amtBid = 0
            amountBid = "0"
            amountBidPlus(str: string)
            amountBidMinus(str: string)
        }
        yearsOrMonths()
    }
    
//MARK: UICollectionViewDelegate
    
    func collectionViewNumberOfItemsInSection() -> Int {
        return images.count
    }
    
    func collectionViewCellForItemAt(_ indexPath: IndexPath) -> CalculateCollectionViewCellViewModelType? {
        let image = images[indexPath.row]
        return CalculateCollectionViewCellViewModel(image: image)
    }
    
    func collectionViewDidSelectItemAt(_ indexPath: IndexPath) {
        self.selectedIndexPathItem = indexPath
        image = images[indexPath.row].name
    }
}
