//
//  CustomAnnotationCallout.swift
//  Mapper
//
//  Created by Brett on 11/14/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit

class CustomAnnotationCallout: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    
    init(){
        super.init(frame: .zero)
        let bundle = Bundle(for: CustomAnnotationCallout.self)
        bundle.loadNibNamed("CustomAnnotationCallout", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
