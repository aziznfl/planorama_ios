//
//  ContentView.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import UIKit

class HomeContentView: UIView {
    private lazy var tripTableView: UITableView = UITableView().parent(to: self)
    
    private lazy var tripWraps: [TripWrap] = []
    private lazy var onSelectTrip: (Trip) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(tripWraps: [TripWrap], onSelectTrip: @escaping (Trip) -> Void) {
        self.tripWraps = tripWraps
        self.onSelectTrip = onSelectTrip
        
        tripTableView.reloadData()
    }
    
    // MARK: - Private
    
    private func render() {
        renderTableView()
    }
    
    private func renderTableView() {
        tripTableView.dataSource = self
        tripTableView.delegate = self
        tripTableView.rowHeight = 120
        tripTableView.separatorStyle = .none
        tripTableView.contentInset = .zero
        tripTableView.sectionHeaderTopPadding = 0
        tripTableView.register(TripViewCell.self, forCellReuseIdentifier: TripViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tripTableView.topAnchor.constraint(equalTo: topAnchor),
            tripTableView.leftAnchor.constraint(equalTo: leftAnchor),
            tripTableView.rightAnchor.constraint(equalTo: rightAnchor),
            tripTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension HomeContentView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripWraps.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripWraps[section].list.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tripWrap = tripWraps[section]
        guard tripWrap.list.isEmpty == false else {
            return nil
        }
        
        let header = UIView()
        header.backgroundColor = .white
        
        let label = UILabel().parent(to: header)
        label.text = tripWraps[section].type.capitalized
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
            withIdentifier: TripViewCell.identifier,
            for: indexPath
        ) as! TripViewCell
        let trip = tripWraps[indexPath.section].list[indexPath.row]
        cell.configure(with: trip)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = tripWraps[indexPath.section].list[indexPath.row]
        onSelectTrip(trip)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tripWraps[section].list.isEmpty ? 0 : UITableView.automaticDimension
    }
}
