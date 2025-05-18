//
//  ContentView.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import UIKit

class HomeContentView: UIView {
    private lazy var segmentControl: UISegmentedControl = UISegmentedControl().parent(to: self)
//    private lazy var pageViewController = UIPageViewController(
//        transitionStyle: .scroll,
//        navigationOrientation: .horizontal)
    
    private lazy var trips: [Trip] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(trips: [Trip]) {
        self.trips = trips
        updateView()
    }
    
    private func updateView() {
        segmentControl.removeAllSegments()
        for (index, trip) in trips.enumerated() {
            segmentControl.insertSegment(withTitle: trip.title, at: index, animated: false)
        }
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func render() {
        renderSegmentControl()
        renderPageView()
    }
    
    private func renderSegmentControl() {
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: topAnchor),
            segmentControl.leftAnchor.constraint(equalTo: leftAnchor),
            segmentControl.rightAnchor.constraint(equalTo: rightAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func renderPageView() {
//        addSubview(pageViewController.view)
//        
//        NSLayoutConstraint.activate([
//            pageViewController.view.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
//            pageViewController.view.leftAnchor.constraint(equalTo: leftAnchor),
//            pageViewController.view.rightAnchor.constraint(equalTo: rightAnchor),
//            pageViewController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
//        ])
    }
}
