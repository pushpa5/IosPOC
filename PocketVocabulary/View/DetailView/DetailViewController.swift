//
//  DetailViewController.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 24/08/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var item = 0 {
        didSet {
            questionNumberLabel.text = "Question : \(item+1)"
        }
    }
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var optionButtons: [CustomButton]!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateQuestion), name: NSNotification.Name(rawValue: "total"), object: nil)
        view.backgroundColor = Theme.accentColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         previousButton.isHidden = true
         updatePage()
    }
    @objc func updateQuestion(notifcation: Notification) {
        guard let popUpVC = notifcation.object as? PopUpViewViewController else {
            fatalError("unexpected notification")
        }
        item = popUpVC.questionSelcted
        nextButton.isHidden = (item == Home.meterial.count-1) ? true : false
        previousButton.isHidden = (item == 0) ? true : false
        updatePage()
    }
    private func updatePage() {
        resetOptionButtons()
        questionLabel.text = Home.meterial[item].question
        for index in 0..<optionButtons.count {
            let option = Home.meterial[item].options
            optionButtons[index].setTitle(option![index], for: .normal)
        }
    }
    private func resetOptionButtons() {
        for index in 0..<optionButtons.count {
            optionButtons[index].backgroundColor = Theme.tintColor
            optionButtons[index].isEnabled = true
            optionButtons[index].setTitleColor(Theme.accentColor, for: .normal)
        }
    }
    private func disableoptionButton() {
        for index in 0..<optionButtons.count {
            optionButtons[index].isEnabled = false
        }
    }
    @IBAction func optionSelected(_ sender: CustomButton) {
        if sender.tag == Home.meterial[item].answer {
            sender.backgroundColor = Theme.correctAnsColor
            sender.setTitleColor(Theme.tintColor, for: .normal)
            disableoptionButton()
        } else {
            sender.backgroundColor = Theme.incorrectAnswer
            sender.setTitleColor(Theme.tintColor, for: .normal)
            optionButtons[ Home.meterial[item].answer!].setTitleColor(Theme.tintColor, for: .normal)
            optionButtons[Home.meterial[item].answer!].backgroundColor = Theme.correctAnsColor
            disableoptionButton()
        }
    }
    @IBAction func nextButtontapped(_ sender: UIButton) {

        if item < Home.meterial.count-1 {
            previousButton.isHidden = false
            item+=1
            updatePage()
            if item == Home.meterial.count-1 {
                nextButton.isHidden = true
            }
        }
    }
    @IBAction func previousButtonTapped(_ sender: UIButton) {

        if item > 0 {
            nextButton.isHidden = false
            item-=1
            updatePage()
            if item == 0 {
                previousButton.isHidden = true
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let popupVC = segue.destination as? PopUpViewViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        popupVC.title = "Go To"
    }
}
