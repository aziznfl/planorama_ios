//
//  HomeViewController.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    private lazy var emptyStateView: EmptyStateView = EmptyStateView().parent(to: view)
    private lazy var accountDetailView: AccountDetailView = AccountDetailView().parent(to: view)
    private lazy var homeContentView: HomeContentView = HomeContentView().parent(to: view)
    private lazy var loadingView: UILabel = UILabel().parent(to: view)
    
    private let tripViewModel = TripViewModel()
    private let accountDetailViewModel = AccountDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        fetchData()
    }
    
    private func fetchData() {
        accountDetailViewModel.fetchData { [weak self] in
            self?.updateAccountDetail()
        }
        tripViewModel.fetchTrips { [weak self] in
            self?.updateViews()
        }
    }
    
    private func updateAccountDetail() {
        guard let account = accountDetailViewModel.user else {
            return
        }
        
        accountDetailView.setup(imageUrl: account.avatarUrl, name: account.name, email: account.email)
    }
    
    private func updateViews() {
        let response = tripViewModel.tripsResponse
        switch (response) {
        case .loading:
            emptyStateView.isHidden = true
            homeContentView.isHidden = true
            loadingView.isHidden = false
            loadingView.text = "Loading..."
        case .failure(let error):
            loadingView.isHidden = true
            homeContentView.isHidden = true
            emptyStateView.isHidden = false
            emptyStateView.setup(title: error.localizedDescription) { [weak self] in
                self?.fetchData()
            }
        case .success(let trips):
            loadingView.isHidden = true
            emptyStateView.isHidden = true
            homeContentView.isHidden = false
            homeContentView.setup(trips: trips)
        case .idle:
            loadingView.isHidden = true
            emptyStateView.isHidden = true
            homeContentView.isHidden = true
        }
    }
    
    // MARK: Render
    
    private func render() {
        renderAccountDetail()
        renderContentView()
        renderEmptyState()
        renderLoading()
    }
    
    private func renderAccountDetail() {
        NSLayoutConstraint.activate([
            accountDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountDetailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            accountDetailView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    private func renderContentView() {
        NSLayoutConstraint.activate([
            homeContentView.topAnchor.constraint(equalTo: accountDetailView.bottomAnchor),
            homeContentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            homeContentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            homeContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func renderEmptyState() {
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: accountDetailView.bottomAnchor),
            emptyStateView.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyStateView.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func renderLoading() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: accountDetailView.bottomAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        // Leave this empty unless you need to update the UI
    }
}
