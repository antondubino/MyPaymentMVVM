//
//  ReportRealmData.swift
//  MyPayment
//
//  Created by Антон Дубино on 26.12.2021.
//

import Foundation
import RealmSwift

class ReportIncomeData: Object {
    
    @objc dynamic var incomeDate: String = ""
    @objc dynamic var incomeSum: String = ""
}

class ReportConsumptionData: Object {
    
    @objc dynamic var consumptionDate: String = ""
    @objc dynamic var consumptionSum: String = ""
}

class ReportPersistance {
    
    static let shared = ReportPersistance()
    
    private let realm = try! Realm()
    
    func saveIncome(item: ReportIncomeData) {
        try! realm.write{
            realm.add(item)
        }
    }
    
    func getItemsIncome() -> Results<ReportIncomeData> {
        realm.objects(ReportIncomeData.self)
    }
    
    func removeAllIncome() {
        try! realm.write {
            for i in getItemsIncome() {
                realm.delete(i)
            }
        }
    }
    
    func saveConsumption(item: ReportConsumptionData) {
        try! realm.write{
            realm.add(item)
        }
    }
    
    func getItemsConsumption() -> Results<ReportConsumptionData> {
        realm.objects(ReportConsumptionData.self)
    }
    
    func removeAllConsumption() {
        try! realm.write {
            for i in getItemsConsumption() {
                realm.delete(i)
            }
        }
    }
}
