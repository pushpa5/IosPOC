//
//  ViewController.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 23/08/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var modal1: TopicsData?
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchModel(name: "Topicsdata") { (modal) in
            self.modal1 = modal
            //tableview.reloadData()
        }
        view.backgroundColor = Theme.accentColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.tableFooterView = UIView()
        infoButton.settingradiousandcolor()
    }
    func fetchModel(name: String, completion: (TopicsData?) -> Void) {
        guard let path = Bundle.main.path(forResource: name, ofType: ".plist"),
            let dictionary = NSDictionary(contentsOfFile: path) else { return }
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            let modal = try JSONDecoder().decode(TopicsData.self, from: data)
            completion(modal)
        } catch {
            print(error.localizedDescription)
            completion(nil)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((modal1?.topics?.count)! + 1)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != (modal1?.topics?.count) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell.textLabel?.text = modal1?.topics?[indexPath.row].topicName
        let selectedView = UIView()
        selectedView.backgroundColor = Theme.accentColor
        cell.selectedBackgroundView = selectedView
        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell.textLabel?.text = "Practice test"
            let selectedView = UIView()
            selectedView.backgroundColor = Theme.accentColor
            cell.selectedBackgroundView = selectedView
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = Theme.tintColor
        if cell?.reuseIdentifier == "cell2" {
            let alert = UIAlertController(title: "alert", message: "Do you want to start the test?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes", style: .default) { (_) in
                self.performSegue(withIdentifier: "totestviewcontroller", sender: nil)
            }
            let cancel = UIAlertAction(title: "No", style: .default, handler: nil)
            alert.addAction(cancel)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = Theme.defaultTextColor
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todetailview"{
            guard let detailVC = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let selectedCell = sender as? UITableViewCell
            let indexPath = tableview.indexPath(for: selectedCell!)
            detailVC.title = modal1?.topics?[(indexPath?.row)!].topicName
            print((modal1?.topics?[(indexPath?.row)!].meterials)!)
            Home.meterial = (modal1?.topics?[(indexPath?.row)!].meterials)!
        } else if segue.identifier == "totestviewcontroller" {
            guard let testVC = segue.destination as? TestViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            testVC.title = "Practice test"
            Home.topics = (modal1?.topics)!
        }
    }

}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
