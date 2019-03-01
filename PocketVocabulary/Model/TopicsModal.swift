//
//  TopicsModal.swift
//  PocketVocabulary
//
//  Created by pushpa.n.bhat on 04/10/18.
//  Copyright © 2018 pushpa.n.bhat. All rights reserved.
//

import Foundation
struct TopicsData: Codable {
    var topics: [Topics]?
    enum CodingKeys: String, CodingKey {
        case topics = "Topics"
    }
}
struct Topics: Codable {
    var topicName: String?
    var meterials: [Meterial]?
    enum CodingKeys: String, CodingKey {
        case topicName = "TopicName"
        case meterials = "Meterial"
    }
}
struct Meterial: Codable {
    var question: String?
    var answer: Int?
    var options: [String]?
    enum CidingKeys: String, CodingKey {
        case question = "question"
        case options = "options"
        case answers = "answer"
    }
}
