//
//  PocketVocabularyTests.swift
//  PocketVocabularyTests
//
//  Created by pushpa.n.bhat on 27/09/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import XCTest
@testable import PocketVocabulary

class PocketVocabularyTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        vc1.viewDidLoad()
        vc1.fetchModel(name: " ") { _ in }
        vc1.tableView(vc1.tableview, didSelectRowAt: IndexPath(row: 0, section: 0))
        vc1.tableView(vc1.tableview, didDeselectRowAt: IndexPath(row: 0, section: 0))
        let num1 = -1
        num1.arc4random
        let num2 = 0
        num2.arc4random
        XCTAssertEqual(8, vc1.modal1?.topics?.count)
    }
    func testDetailviewController() {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        guard let vc2 = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        vc2.viewDidLoad()
        let meterial1 = Meterial(question: "Antonyms", answer: 1, options: ["option1", "option2", "option3", "option4"])
        let meterial2 = Meterial(question: "Synonyms", answer: 2, options: ["option1", "option2", "option3", "option4"])
        Home.meterial = [meterial1, meterial2]
        vc2.viewWillAppear(true)
        if let buttons = vc2.optionButtons {
            vc2.optionSelected(buttons[0])
            vc2.optionSelected(buttons[1])
            vc2.optionSelected(buttons[2])
            vc2.optionSelected(buttons[3])
        }
        vc2.nextButtontapped(UIButton())
        vc2.previousButtonTapped(UIButton())
    }
    func testTestviewcontroller() {
        let storyboard = UIStoryboard(name: "TestViewController", bundle: nil)
        guard let vc3 = storyboard.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController else {
            return
        }
        let meterial1 = Meterial(question: "question1", answer: 1, options: ["option1", "option2", "option3", "option4"])
        let meterial2 = Meterial(question: "question2", answer: 2, options: ["option1", "option2", "option3", "option4"])
        Home.meterial = [meterial1, meterial2, meterial1, meterial2, meterial1, meterial1, meterial2]
        let topic1 = Topics(topicName: "Antonyms", meterials: [meterial1, meterial2, meterial1, meterial2, meterial1, meterial1, meterial2])
        let topic2 = Topics(topicName: "Synonyms", meterials: [meterial1, meterial2, meterial1, meterial2, meterial1, meterial1, meterial2])
        Home.topics = [topic1, topic2, topic2, topic1, topic1, topic2]
        vc3.viewDidLoad()
        vc3.viewWillAppear(true)
        if let buttons = vc3.optionButtons {
            vc3.optionSelected(buttons[0])
            vc3.optionSelected(buttons[1])
            vc3.optionSelected(buttons[2])
            vc3.optionSelected(buttons[3])
        }
        vc3.nextButtonTapped(UIButton())
        vc3.previousButonTapped(UIButton())
    }
    func testResultviewController() {
        let storyboard = UIStoryboard(name: "ResultViewController", bundle: nil)
        guard let vc4 = storyboard.instantiateViewController(withIdentifier: "UIViewController-NQ8-VC-KRd") as? ResultViewController else {
            return
        }
        vc4.viewDidLoad()
        vc4.loadViewIfNeeded()
        XCTAssertNotNil(vc4.tableView, "Controller should have a tableview")
        vc4.result = ["correct", "wrong"]
        vc4.viewWillAppear(true)
        vc4.homeButtonTapped(UIButton())
    }
    func testPopupViewcontroller() {
        let storyboard = UIStoryboard(name: "PopUpViewController", bundle: nil)
        guard let vc5 = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewViewController else {
            return
        }
        vc5.viewDidLoad()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
