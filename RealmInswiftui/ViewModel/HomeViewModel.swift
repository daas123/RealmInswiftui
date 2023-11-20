//
//  HomeViewModel.swift
//  RealmInswiftui
//
//  Created by Neosoft on 20/11/23.
//

import Foundation
import RealmSwift
class HomeViewModel: ObservableObject {
    
    private let realmServices = RealmServices.shared
    @Published var empData: Results<empModel> = RealmServices.shared.readempData()
    @Published var isAddingNew = false
    @Published var selectedEmployee: empModel?
    
    init() {
        empData = realmServices.readempData()
    }
    
    func edit(emp: empModel) {
        selectedEmployee = emp
        isAddingNew = true
    }
    
    
//    func delete(emp: empModel) {
//        RealmServices.shared.deleteData(object: emp)
//        DispatchQueue.main.async {
//            self.empData = RealmServices.shared.readempData()
//        }
//    }
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }

        let empToDelete = empData[index]

        do {
            try realmServices.deleteData(object: empToDelete)
            // Update empData after deletion
            empData = realmServices.readempData()
        } catch {
            print("Error deleting object: \(error)")
        }
    }


}
