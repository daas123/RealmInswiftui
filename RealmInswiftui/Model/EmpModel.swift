//
//  EmpModel.swift
//  RealmInswiftui
//
//  Created by Neosoft on 20/11/23.
//

import Foundation
import RealmSwift

// object class is use to define realm model Object

class empModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var phoneNo: String

    // Add the required init() initializer
    override init() {
        // Initialize the properties after calling super.init()
        super.init()
        self.id = ObjectId.generate()
        self.name = ""
        self.phoneNo = ""
    }

    init(name: String, phoneNo: String) {
        self.name = name
        self.phoneNo = phoneNo
        super.init()
    }
}


