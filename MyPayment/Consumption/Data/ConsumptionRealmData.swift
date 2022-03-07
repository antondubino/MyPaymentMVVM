//
//  ConsumptionRealmData.swift
//  MyPayment
//
//  Created by Антон Дубино on 19.12.2021.
//

import Foundation
import RealmSwift

class ConsumptionData: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date?
    @objc dynamic var seconds: Int = 0
    @objc dynamic var sum: String = ""
    @objc dynamic var image: String = ""
}

class ConsumptionPersistance {
    
    static let shared = ConsumptionPersistance()
    
    private let realm = try! Realm()
    
    func save(item: ConsumptionData) {
        try! realm.write{
            realm.add(item)
        }
    }
    
    func getItems() -> Results<ConsumptionData> {
        realm.objects(ConsumptionData.self)
    }
    
    func remove(item: ConsumptionData) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
