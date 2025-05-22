//
//  TripDetailContentView.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 20/05/25.
//

import UIKit

class TripDetailContentView: UIView {
    private lazy var closeButton: UIButton = UIButton().parent(to: self)
    private lazy var tableView: UITableView = UITableView().parent(to: self)
    
    private var tripDetails: TripDetails? {
        didSet {
            tableView.reloadData()
        }
    }
    private var onTapClose: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tripDetails: TripDetails, onTapClose: @escaping () -> Void) {
        self.tripDetails = tripDetails
        self.onTapClose = onTapClose
    }
    
    @objc private func dismissView() {
        self.onTapClose?()
    }
    
    private func render() {
        closeButton.setImage(.remove, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.sectionHeaderTopPadding = 0
        tableView.dragInteractionEnabled = true
        tableView.register(TripPlaceViewCell.self, forCellReuseIdentifier: TripPlaceViewCell.identifier)
        tableView.register(AddTripPlaceViewCell.self, forCellReuseIdentifier: AddTripPlaceViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension TripDetailContentView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripDetails?.schedules.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripDetails?.schedules[section].activities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
        
        let label = UILabel().parent(to: header)
        label.text = tripDetails?.schedules[section].date
        label.font = .systemFont(ofSize: 20, weight: .bold)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: header.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -8),
        ])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TripPlaceViewCell.identifier,
            for: indexPath
        ) as! TripPlaceViewCell
        if let trip = tripDetails?.schedules[indexPath.section].activities[indexPath.row] {
            cell.configure(with: trip)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = .zero
        
        if (indexPath.row == 0) {
            cell.separatorInset = .zero
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("move it")
    }
}

extension TripDetailContentView: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: any UITableViewDropCoordinator) {
        
    }
}
