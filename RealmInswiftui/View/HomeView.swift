//
//  HomeView.swift
//  RealmInswiftui
//
//  Created by Neosoft on 20/11/23.
//
import SwiftUI
import RealmSwift
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.empData) { emp in
                        NavigationLink(destination: DetailView(emp: emp)) {
                            Text(emp.name)
                        }
                        .contextMenu {
                            Button("Edit") {
                                viewModel.edit(emp: emp)
                            }
//                            Button("Delete") {
//                                viewModel.delete(emp: emp)
//                            }
                        }
                    }.onDelete { indexSet in
                        viewModel.delete(at: indexSet)
                    }
                }
                .navigationBarTitle("Employee List")
                .navigationBarItems(trailing:
                    Button(action: {
                        viewModel.isAddingNew = true
                    }) {
                        Image(systemName: "plus")
                    }
                )
            }
            .sheet(isPresented: $viewModel.isAddingNew) {
                if let selectedEmployee = viewModel.selectedEmployee {
                    AddEmployeeView(viewModel: viewModel, editingEmployee: selectedEmployee)
                } else {
                    AddEmployeeView(viewModel: viewModel)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
