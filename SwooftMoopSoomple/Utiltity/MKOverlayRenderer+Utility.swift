//
//  MKOverlayRenderer+Utility.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import MapKit

private let RENDERER_LINE_WIDTH: CGFloat = 5.0
private let RENDERER_ALPHA_VALUE: CGFloat = 0.1

extension MKOverlayRenderer {
    static func blueRenderer(overlay: MKOverlay) -> MKOverlayRenderer {
        let color = UIColor(red: 0/255,
                            green: 122/255,
                            blue: 255/255,
                            alpha: 1.0)
        return MKOverlayRenderer.renderer(color: color,
                                          overlay: overlay)
    }
    static func renderer(color: UIColor,
                         overlay: MKOverlay,
                         lineWidth: CGFloat = RENDERER_LINE_WIDTH,
                         alphaValue: CGFloat = RENDERER_ALPHA_VALUE) -> MKOverlayRenderer {
        let r = MKCircleRenderer(overlay: overlay)
        r.lineWidth = lineWidth
        r.strokeColor = color
        r.fillColor = color.withAlphaComponent(alphaValue)
        return r
        
    }
}
