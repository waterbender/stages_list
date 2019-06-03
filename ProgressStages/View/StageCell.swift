//
//  StageCell.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import UIKit

public class StageCell: UITableViewCell {

    @IBOutlet weak var readyFlagView: StageReadyIconView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var stageDisc: UIButton!

    static let stagesColors: [UIColor] = [UIColor(named: "C42D63") ?? UIColor.clear,
                                          UIColor(named: "872A5F") ?? UIColor.clear,
                                          UIColor(named: "55275A") ?? UIColor.clear]

    override public func awakeFromNib() {
        super.awakeFromNib()
        let origImage = UIImage(named: "16049")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        stageDisc.setImage(tintedImage, for: .normal)
        stageDisc.tintColor = .lightGray
    }

    func bind(stage: StageCodable) {
        let isComplited = stage.status == "completed"
        readyFlagView.basicNumber = stage.step ?? 0
        readyFlagView.isComplited = isComplited

        cellTitle.text = stage.title
        cellDescription.text = stage.subtitle

        guard let step = stage.step else {
            return
        }
        let color = StageCell.stagesColors[step - 1]
        switch stage.status {
        case "completed":
            cellTitle.textColor = .black
            cellDescription.textColor = .lightGray
            readyFlagView.color = color
        case "inProgress":
            cellTitle.textColor = color
            cellDescription.textColor = .black
            readyFlagView.color = color
        case "pending":
            cellTitle.textColor = .black
            cellDescription.textColor = .lightGray
            readyFlagView.color = .lightGray
        default:
            break
        }
    }
}
