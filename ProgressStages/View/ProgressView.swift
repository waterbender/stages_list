//
//  ProgressView.swift
//  ProgressStages
//
//  Created by Yevgenii Pasko on 6/3/19.
//  Copyright © 2019 Yevgenii Pasko. All rights reserved.
//

import UIKit

public class ProgressView: UIView {

    var overlayLayer: CALayer? {
        didSet {
            if let overlay = self.overlayLayer {
                self.layer.addSublayer(overlay)
            }
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        if let overlayUnwr = overlayLayer {
            overlayUnwr.frame = bounds
        }
    }
}
