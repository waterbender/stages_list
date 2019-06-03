//
//  StageReadyIconView.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import UIKit

@IBDesignable
public class StageReadyIconView: BorderedView {
    private let imageView = UIImageView()
    private let indexLabel = UILabel()

    var color: UIColor = UIColor(named: "872A5F") ?? UIColor.black {
        didSet {
            if isComplited {
                backgroundColor = color
            } else {
                backgroundColor = .clear
                indexLabel.textColor = color
                backgroundColor = .groupTableViewBackground
            }

            borderColor = color
        }
    }

    @IBInspectable public var complitedImage: UIImage? = UIImage(named: "icon-completed")
    @IBInspectable public var basicNumber: Int = 0 {
        didSet {
            self.indexLabel.text = "\(self.basicNumber)"
        }
    }
    @IBInspectable public var isComplited: Bool = false {
        didSet {
            updateHidden()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupImageView()
        setupLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        setupImageView()
        setupLabel()
    }

    private func setupImageView() {
        imageView.frame = self.bounds
        self.addSubview(imageView)
        imageView.image = complitedImage
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    private func setupLabel() {
        indexLabel.frame = self.bounds
        self.addSubview(indexLabel)
        indexLabel.backgroundColor = .clear
        indexLabel.textAlignment = .center
        indexLabel.textColor = color
        indexLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        indexLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        indexLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        indexLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    private func updateHidden() {
        if isComplited {
            imageView.isHidden = false
            indexLabel.isHidden = true
            backgroundColor = color
        } else {
            imageView.isHidden = true
            indexLabel.isHidden = false
            backgroundColor = .clear
        }
    }
}
