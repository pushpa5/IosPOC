//
//  CustomButton.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 24/08/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import Foundation
import UIKit
class CustomButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = Theme.accentColor?.cgColor
        self.layer.borderWidth = 1.0
    }
}
