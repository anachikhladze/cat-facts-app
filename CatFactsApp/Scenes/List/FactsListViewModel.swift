//
//  FactsListViewModel.swift
//  CatFactsApp
//
//  Created by Anna Sumire on 19.11.23.
//

import Foundation
import FactService

protocol FactsListViewModelDelegate: AnyObject {
    func factsFetched(_ facts: [Fact])
    func showError(_ error: Error)
}

final class FactsListViewModel {
    private var facts: [Fact]?
    weak var delegate: FactsListViewModelDelegate?
    
    func viewDidLoad() {
        fetchFacts()
    }
    
    private func fetchFacts() {
        FactService.shared.fetchFacts { [weak self] result in
            switch result {
            case .success(let facts):
                self?.facts = facts
                self?.delegate?.factsFetched(facts)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
