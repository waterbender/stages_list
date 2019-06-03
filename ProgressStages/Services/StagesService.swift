//
//  StagesService.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import UIKit

protocol ServiceProtocol {
}

public class StagesService: ServiceProtocol {

    let fileBase = "data"

    func getStagesForStep(step: Int,
                          compliteClousure: ([StageCodable]) -> Void,
                          failure: ((NSError) -> Void)? = nil) {

        let fileName = fileBase + "\(step)"

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                let stagesArray = try? JSONDecoder().decode(StagesCodable.self,
                                                            from: data)
                compliteClousure(stagesArray?.steps ?? [])
            } catch {
                let error = NSError(domain: "not able to get data",
                                    code: 433,
                                    userInfo: [:])
                if let failureClousure = failure {
                    failureClousure(error)
                }
            }
        }
    }
}
