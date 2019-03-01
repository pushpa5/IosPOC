//
//  PopUpViewViewController.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 24/08/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import UIKit

class PopUpViewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var numberofQuestions = 0
    var questionSelcted = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Home.meterial.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            return CollectionViewCell()
        }
        cell.collectionLabel.text = String(indexPath.item + 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        questionSelcted = indexPath.item
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "total"), object: self)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "test"), object: self)
        dismiss(animated: true)

    }
}
