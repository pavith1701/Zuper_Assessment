//
//  DashBoardListView.swift
//  ZuperAssessment
//
//  Created by Pavithran P K on 10/07/25.
//

import SwiftUI
import Combine
import ServicesSampleData

struct DashBoardListView: View {
    
    @StateObject private var viewModel = ServicesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBar(text: $viewModel.searchText)
                Spacer()
                FilterBar(status: $viewModel.statusFilter, priority: $viewModel.priorityFilter)
                
                List(viewModel.filteredServices) { service in
                    NavigationLink(destination: ServiceDetailView(service: service)) {
                        ServiceRow(service: service)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.refresh()
                }
            }
            .navigationTitle("Services")
        }
        
    }
}
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search by title or customer", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .padding(.top)
    }
}
struct FilterBar: View {
    @Binding var status: ServiceStatus?
    @Binding var priority: Priority?
    
    var body: some View {
        VStack {
            Picker("Status", selection: $status) {
                
                ForEach(ServiceStatus.allCases, id: \.self) {
                    Text($0.rawValue).tag(ServiceStatus?.some($0))
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Priority", selection: $priority) {
                
                ForEach(Priority.allCases, id: \.self) {
                    Text($0.rawValue).tag(Priority?.some($0))
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
}
struct ServiceRow: View {
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(service.title).font(.headline)
            Text(service.customerName).font(.subheadline).foregroundColor(.secondary)
            Text(service.scheduledDate.toRelativeDateString()).font(.caption).foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
struct ServiceDetailView: View {
    let service: Service
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    Text("Title: \(service.title)")
                    Text("Customer: \(service.customerName)")
                    Text("Status: \(service.status.rawValue)")
                    Text("Priority: \(service.priority.rawValue)")
                    Text("Scheduled: \(service.scheduledDate.toRelativeDateString())")
                    Text("Location: \(service.location)")
                }
                
                Divider()
                
                Text("Description:")
                Text(service.description)
                
                Text("Notes:")
                Text(service.serviceNotes)
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}


#Preview {
    DashBoardListView()
}
