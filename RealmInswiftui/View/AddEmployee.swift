//
//  AddEmployee.swift
//  RealmInswiftui
//
//  Created by Neosoft on 20/11/23.
//
import SwiftUI
struct AddEmployeeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var name: String
    @State private var phoneNo: String

    var editingEmployee: empModel?

    init(viewModel: HomeViewModel, editingEmployee: empModel? = nil) {
        self.viewModel = viewModel
        self.editingEmployee = editingEmployee
        _name = State(initialValue: editingEmployee?.name ?? "")
        _phoneNo = State(initialValue: editingEmployee?.phoneNo ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Employee Details")) {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $phoneNo)
                }

                Section {
                    Button("Save") {
                        saveEmployee()
                    }
                }
            }
            .onAppear {
                // Initialize fields if editing
                if let editingEmployee = editingEmployee {
                    name = editingEmployee.name
                    phoneNo = editingEmployee.phoneNo
                }
            }
            .navigationTitle(editingEmployee != nil ? "Edit Employee" : "Add Employee")
            .navigationBarItems(trailing:
                Button("Cancel") {
                    viewModel.isAddingNew = false
                }
            )
        }
    }

    func saveEmployee() {
        if let editingEmployee = editingEmployee {
            let updatedEmployee = empModel(name: name, phoneNo: phoneNo)
            RealmServices.shared.updateData(object: editingEmployee, newModel: updatedEmployee)
        } else {
            let newEmployee = empModel(name: name, phoneNo: phoneNo)
            RealmServices.shared.createObject(details: newEmployee)
        }
        viewModel.empData = RealmServices.shared.readempData()
        viewModel.isAddingNew = false
    }
}

struct DetailView: View {
    let emp: empModel

    var body: some View {
        VStack {
            Text(emp.name)
            Text(emp.phoneNo)
        }
        .navigationBarTitle("Employee Details")
    }
}


