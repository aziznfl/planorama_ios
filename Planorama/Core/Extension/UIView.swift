//
//  UIView.swift
//  Planorama
//
//  Created by Aziz Nurfalah on 11/05/25.
//

import UIKit

extension UIView {
    @discardableResult
    func parent(to view: UIView) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }
}
