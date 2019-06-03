//
//  StagesViewModel.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import CoreGraphics
import Foundation

class StagesViewModel {

    private var stages: [StageCodable] = []
    private var sortedStages: [StageCodable] = []

    func insertStages(stages: [StageCodable]) {
        self.stages = stages
        self.sortedStages = stages.sorted { stage1, stage2 -> Bool in
            stage1.step ?? 0 < stage2.step ?? 0
        }
    }

    func numberOfRows() -> Int {
        return sortedStages.count
    }

    func getStageAt(row: Int) -> StageCodable {
        return sortedStages[row]
    }

    func isComplited(row: Int) -> Bool {
        let stage = sortedStages[row]
        return stage.status == "completed" || stage.status == "inProgress"
    }
}
