//
//  ViewController.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import UIKit

class StagesViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private let service = StagesService()
    private let viewModel = StagesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        loadData()
    }

    func setupTable() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }

    private func loadData() {
    // swiftlint:disable trailing_closure
        service.getStagesForStep(step: 3,
                                 compliteClousure: { [unowned self] stages in
                                    print(Thread.current)
                                    viewModel.insertStages(stages: stages)
                                    self.tableView.reloadData()
                                    self.buildProgress()
        })
    }
    // swiftlint:enable trailing_closure
}

extension StagesViewController {
    private func buildProgress() {

        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()

        let colors = StageCell.stagesColors
        for index in 0..<viewModel.numberOfRows() where index < colors.count - 1 {
            if viewModel.isComplited(row: index + 1) {
                buildConnectLineFrom(indexPath1: IndexPath(row: index + 1, section: 0),
                                     to: IndexPath(row: index + 2, section: 0),
                                     color1: colors[index],
                                     color2: colors[index + 1])
            } else {
                buildConnectLineFrom(indexPath1: IndexPath(row: index + 1, section: 0),
                                     to: IndexPath(row: index + 2, section: 0))
            }
        }
    }

    private func buildConnectLineFrom(indexPath1: IndexPath,
                                      to indexPath2: IndexPath,
                                      color1: UIColor? = nil,
                                      color2: UIColor? = nil) {

        guard let cellF = tableView.cellForRow(at: indexPath1) as? StageCell,
            let cellS = tableView.cellForRow(at: indexPath2) as? StageCell else {
                return
        }

        let progressView = ProgressView()
        progressView.backgroundColor = .clear
        tableView.addSubview(progressView)

        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: cellF.readyFlagView.bottomAnchor).isActive = true
        progressView.centerXAnchor.constraint(equalTo: cellF.readyFlagView.centerXAnchor).isActive = true
        progressView.bottomAnchor.constraint(equalTo: cellS.readyFlagView.topAnchor).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 4).isActive = true

        progressView.setNeedsDisplay()
        progressView.layoutIfNeeded()

        if let color1Unw = color1?.cgColor, let color2Unw = color2?.cgColor {
            let colors: [CGColor] = [color1Unw, color2Unw]

            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = progressView.bounds
            gradientLayer.colors = colors
            progressView.overlayLayer = gradientLayer
        } else {
            let path = CGMutablePath()
            let shapeLayer = CAShapeLayer()
            shapeLayer.lineWidth = 4
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.lineDashPattern = [ 3, 3 ]
            path.addLines(between: [CGPoint(x: 2, y: 0),
                                    CGPoint(x: 2, y: progressView.bounds.maxY)])
            shapeLayer.path = path
            progressView.overlayLayer = shapeLayer
        }

        tableView.visibleCells.forEach { cell in
            tableView.bringSubviewToFront(cell)
        }
    }
}

extension StagesViewController: UITableViewDelegate, UITableViewDataSource {
    static let titleIdentifier = "TitleCellIdentifier"
    static let descriptionIdentifier = "BasicCellIdentifier"

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows() + 1
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: StagesViewController.titleIdentifier)
        } else {
            let stage = viewModel.getStageAt(row: indexPath.row - 1)
            cell = tableView.dequeueReusableCell(withIdentifier: StagesViewController.descriptionIdentifier)
            (cell as? StageCell)?.bind(stage: stage)
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
