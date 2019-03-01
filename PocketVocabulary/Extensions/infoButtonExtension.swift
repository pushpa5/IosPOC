//
//  infoButtonExtension.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 05/09/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import UIKit

extension UIButton {
    func settingradiousandcolor() {
        layer.cornerRadius = frame.height / 2
        layer.backgroundColor = Theme.tintColor?.cgColor
        setTitleColor(Theme.accentColor, for: .normal)
    }
}
