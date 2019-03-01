//
//  ResultViewController.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 31/08/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import UIKit
import Charts

class ResultViewController: UIViewController {
    var result = [String]()
    var unanswered = PieChartDataEntry(value: 0)
    var correctanswers = PieChartDataEntry(value: 0)
    var wronganswers = PieChartDataEntry(value: 0)
    var answeranalysys = [PieChartDataEntry]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewWillAppear(true)
        tableView.reloadData()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        var correctAnswerCount = 0.0
        var incorrectAnswerCount = 0.0
        var unansweredCount = 0.0
        for index in 0..<result.count {
            if result[index] == "wrong" {
                incorrectAnswerCount += 1
            } else if result[index] == "correct" {
                correctAnswerCount += 1
            } else {
                unansweredCount += 1
            }
        }
        pieChart.chartDescription?.text = ""
        correctanswers.value = correctAnswerCount
        correctanswers.label = "correct"
        wronganswers.value = incorrectAnswerCount
        wronganswers.label = "Incorrect"
        unanswered.value = unansweredCount
        unanswered.label = "Unanswered"
        answeranalysys = [unanswered, correctanswers, wronganswers]
        updateChart()
    }
    func updateChart() {
        let chartDataset = PieChartDataSet(values: answeranalysys, label: nil)
        let chartData = PieChartData(dataSet: chartDataset)
        let colors = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
        chartDataset.colors = colors
        pieChart.data = chartData
    }
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            return CustomTableViewCell()
        }
        cell.contentView.sizeToFit()
        cell.userAnswerLabel.text = String(indexPath.row + 1)+". "+result[indexPath.row]
        if result[indexPath.row] == "wrong" || result[indexPath.row] == "not answered" {
            if let answers = Home.meterial[indexPath.row].answer {
            cell.correctAnswerLabel.text = Home.meterial[indexPath.row].options?[answers]
            }
            cell.correctAnswerLabel.numberOfLines = 0
        } else {
            cell.correctAnswerLabel.text = "-"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
