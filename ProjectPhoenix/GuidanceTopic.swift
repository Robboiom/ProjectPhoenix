//
//  GuidanceTopic.swift
//  ProjectPhoenix
//
//  Created by JASON ROBERTS on 10/04/2026.
//

import Foundation
import SwiftData

@Model
class GuidanceTopic {
    var topicId: Int
    var title: String
    var content: String

    init(topicId: Int, title: String, content: String) {
        self.topicId = topicId
        self.title = title
        self.content = content
    }
}
