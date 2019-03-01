//
//  TestViewController.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 28/08/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    var selectedOptions = [Int]()
    var item = 0
    var results = [String]()
    var tempArray = [Topics]()
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var optionButtons: [CustomButton]!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Home.meterial = []
        for _ in 0..<5 {
            let random = Home.topics.count.arc4random
            tempArray.append(Home.topics[random])
            Home.topics.remove(at: random)
        }
        Home.topics = tempArray
        for index in 0..<Home.topics.count {
            let matCount = Home.topics[index].meterials?.count ?? 0
            let extraCount = matCount - 5
            if extraCount > 0 {
                for _ in 0..<extraCount {
                    let random = Home.topics[index].meterials?.count.arc4random
                    if Home.topics[index].meterials?.count ?? 0 > 0 {
                        Home.topics[index].meterials?.remove(at: random!)
                    }
                }
            }
            for num in 0..<5 {
                if Home.topics[index].topicName == "Antonyms" {
                    Home.topics[index].meterials?[num].question!.append(" (ANTONYM)")
                } else if Home.topics[index].topicName == "Synonyms" {
                    Home.topics[index].meterials?[num].question!.append(" (SYNONYM)")
                }
            }
            Home.meterial.append(contentsOf: Home.topics[index].meterials!)
        }
        for _ in 0..<Home.meterial.count {
            selectedOptions.append(5)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updatetestQuestion), name: NSNotification.Name(rawValue: "test"), object: nil)
        view.backgroundColor = Theme.accentColor
    }
    override func viewWillAppear(_ animated: Bool) {
        previousButton.isHidden = true
        super.viewWillAppear(true)
        self.navigationItem.hidesBackButton = true
        updatePage()
    }
    @objc func updatetestQuestion(notifcation: Notification) {
        guard let popUpVC = notifcation.object as? PopUpViewViewController else {
            fatalError("unexpected notification from PopUpViewViewController")
        }
        item = popUpVC.questionSelcted
        nextButton.isHidden = (item == Home.meterial.count-1) ? true : false
        previousButton.isHidden = (item == 0) ? true : false
        updatePage()
    }
    private func updatePage() {
        resetOptionButtons()
        if selectedOptions[item] != 5 {
            optionButtons[selectedOptions[item]].backgroundColor = Theme.selectedOption
             optionButtons[selectedOptions[item]].setTitleColor(Theme.tintColor, for: .normal)
        }
        questionLabel.text = Home.meterial[item].question
        for index in 0..<optionButtons.count {
            let option = Home.meterial[item].options![index]
            optionButtons[index].setTitle(option, for: .normal)
        }
    }
    private func resetOptionButtons() {
        for index in 0..<optionButtons.count {
            optionButtons[index].backgroundColor = Theme.tintColor
            optionButtons[index].isEnabled = true
            optionButtons[index].setTitleColor(Theme.accentColor, for: .normal)
        }
    }
    @IBAction func optionSelected(_ sender: CustomButton) {

        for button in optionButtons {
            if sender.tag == button.tag {
                button.backgroundColor = Theme.selectedOption
                button.setTitleColor(Theme.tintColor, for: .normal)
                selectedOptions[item] = sender.tag
            } else {
            button.backgroundColor = Theme.tintColor
            button.setTitleColor(Theme.accentColor, for: .normal)
            }
        }

    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if item < Home.meterial.count-1 {
            previousButton.isHidden = false
            item+=1
            updatePage()
            if item == Home.meterial.count-1 {
                nextButton.isHidden = true
            }
        }
    }

    @IBAction func previousButonTapped(_ sender: UIButton) {
        if item > 0 {
            nextButton.isHidden = false
            item-=1
            updatePage()
            if item == 0 {
                previousButton.isHidden = true
            }
        }
    }
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        if sender.currentTitle == "finish" {
            for index in 0..<Home.meterial.count {
                if Home.meterial[index].answer == selectedOptions[index] {
                    results.append("correct")
                } else if selectedOptions[index] == 5 {
                    results.append("not answered")
                } else {
                    results.append("wrong")
                }
            }
        }
        if sender.currentTitle == "finish" {
            let alert = UIAlertController(title: "Alert", message: "Do you want to submit the test?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes", style: .default) { (_) in
                sender.setTitle("Result Page", for: .normal)
                self.performSegue(withIdentifier: "toresultviewcontroller", sender: nil)
            }
            let noButton = UIAlertAction(title: "No", style: .default, handler: nil)
            alert.addAction(noButton)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if sender.currentTitle == "Result Page"{
            performSegue(withIdentifier: "toresultviewcontroller", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromtestview" {
            guard let popupVC = segue.destination as? PopUpViewViewController else {
                fatalError("unexpected destination \(segue.destination)")
            }
            popupVC.numberofQuestions = Home.meterial.count
        } else if segue.identifier == "toresultviewcontroller" {
            guard let resultVC = segue.destination as? ResultViewController else {
                fatalError("unexpected destination \(segue.destination)")
            }
            resultVC.title = "Result"
            resultVC.result = results
        }
    }

}
