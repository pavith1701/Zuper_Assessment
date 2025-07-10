//
//  ServicesViewModel.swift
//  ZuperAssessment
//
//  Created by Pavithran P K on 10/07/25.
//

import Foundation
import ServicesSampleData
import Combine

class ServicesViewModel: ObservableObject {
    @Published var allServices: [Service] = []
    @Published var filteredServices: [Service] = []

    @Published var searchText = ""
    @Published var statusFilter: ServiceStatus? = nil
    @Published var priorityFilter: Priority? = nil

    private var cancellables = Set<AnyCancellable>()

    init() {
        load()
        
        Publishers.CombineLatest3($searchText.debounce(for: .milliseconds(300), scheduler: RunLoop.main),
                                  $statusFilter,
                                  $priorityFilter)
            .sink { [weak self] _, _, _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }

    func load() {
        allServices = SampleData.generateServices(count: 20)
        applyFilters()
    }

    func refresh() {
        load()
    }

    func applyFilters() {
        var result = allServices

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.customerName.localizedCaseInsensitiveContains(searchText)
            }
        }

        if let status = statusFilter {
            result = result.filter { $0.status == status }
        }

        if let priority = priorityFilter {
            result = result.filter { $0.priority == priority }
        }

        filteredServices = result
    }
}

