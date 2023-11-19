//
//  ViewController.swift
//  CatFactsApp
//
//  Created by Anna Sumire on 19.11.23.
//

import UIKit
import FactService

final class FactsListViewController: UIViewController {
    
    // MARK: - Properties
    private var facts = [Fact]()
    private let viewModel = FactsListViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.viewDidLoad()
    }
    
    private func setup() {
        setupViewModelDelegate()
        setupBackground()
        setupNavigationBar()
        setupSubviews()
        setupTableView()
        setupConstraints()
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
    
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Cat Facts"
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: "FactCell")
        tableView.tableFooterView = UIView()
    }
}

// MARK: - TableViewDataSource & TableViewDelegate
extension FactsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FactCell") as? FactTableViewCell {
            cell.configure(with: facts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: - FactsListViewModelDelegate
extension FactsListViewController: FactsListViewModelDelegate {
    func factsFetched(_ facts: [Fact]) {
        self.facts = facts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("Error")
    }
}
