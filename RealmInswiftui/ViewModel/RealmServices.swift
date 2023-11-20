//
//  RealmServices.swift
//  RealmInswiftui
//
//  Created by Neosoft on 20/11/23.
//

import Foundation
import RealmSwift
class RealmServices{
    private init() {}
    static let shared = RealmServices()
    var realm = try! Realm()
    
    //MARK: initialization of data base
    func createObject(details : empModel){
        let newobject = empModel()
        newobject.name = details.name
        newobject.phoneNo = details.phoneNo
        try! realm.write{
            realm.add(newobject)
        }
    }
    
    //MARK: reading of data
    
    func readempData() -> Results<empModel>{
        return realm.objects(empModel.self)
    }
    
    //MARK: updating the data
    
    func updateData(object:empModel ,newModel :empModel){
        do{
            try realm.write{
                object.name = newModel.name
                object.phoneNo = newModel.phoneNo
            }
        }catch{
            print("there is some error in updating the data")
        }
    }
    
    //MARK: delete operation on data
    
    func deleteData(object: empModel) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
}
