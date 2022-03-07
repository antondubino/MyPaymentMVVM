//
//  RealmData.swift
//  MyPayment
//
//  Created by Антон Дубино on 10.12.2021.
//

import Foundation
import RealmSwift

class IncomeData: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date?
    @objc dynamic var seconds: Int = 0
    @objc dynamic var sum: String = ""
    @objc dynamic var image: String = ""
}

class IncomePersistance {
    
    static let shared = IncomePersistance()
    
    private let realm = try! Realm()
    
    func save(item: IncomeData) {
        try! realm.write{
            realm.add(item)
        }
    }
    
    func getItems() -> Results<IncomeData> {
        realm.objects(IncomeData.self)
    }
    
    func remove(item: IncomeData) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
