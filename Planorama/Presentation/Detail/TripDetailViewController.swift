//
//  TripDetail.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 10/05/25.
//

import Combine
import UIKit

class TripDetailViewController: UIViewController {
    var tripId: Int64 = 0
    
    private lazy var contentView: TripDetailContentView = TripDetailContentView().parent(to: view)
    
    private let tripDetailsViewModel = TripDetailsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    init(tripId: Int64) {
        super.init(nibName: nil, bundle: nil)
        self.tripId = tripId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        title = "Trip Detail"
        
        render()
        bindViewModel()
        fetchData()
    }
    
    private func fetchData() {
        tripDetailsViewModel.fetchTripDetailsBy(id: tripId)
    }
    
    private func bindViewModel() {
        tripDetailsViewModel.$tripDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateViews()
            }
            .store(in: &cancellables)
    }
    
    func updateViews() {
        let response = tripDetailsViewModel.tripDetails
        switch response {
        case .idle:
            contentView.isHidden = true
        case .loading:
            contentView.isHidden = true
        case .failure(_):
            contentView.isHidden = true
        case .success(let tripDetails):
            contentView.isHidden = false
            contentView.configure(tripDetails: tripDetails) { [weak self] in
                self?.dismissView()
            }
        }
    }
    
    // MARK: - Render
    
    private func render() {
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
    
    // MARK: - On Tap
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
}
