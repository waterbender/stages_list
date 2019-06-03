//
//  StageCodable.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import Foundation

class StagesCodable: Codable {
    let steps: [StageCodable]?
}

class StageCodable: Codable {
    let step: Int?
    let title: String?
    let subtitle: String?
    let status: String?
}
