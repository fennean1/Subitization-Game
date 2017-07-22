//
//  Styles.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/14/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    
    func editstyle(_ container: CGRect)
    {
        
        let w = container.width/12
        let h = 2/3*w
        let x = container.width/2 - container.width*3/7
        let y = container.width/18 + 1/4*container.height - h
        
        self.frame = CGRect(x: x, y: y, width: w, height: h)
        
        self.setTitle("Edit", for: UIControlState())
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.titleLabel?.font = UIFont(name: chalkboardfont, size: self.frame.height/2)
        self.bringSubview(toFront: self.titleLabel!)
        self.titleLabel?.textColor = UIColor.white
        self.backgroundColor = UIColor.gray
        
    }
    
    
    
}

// Extensions to CGRect take the container and style it according to the object it's being assigned to. Ex: foo.frame.StyleFoo styles the frame of foo.

extension CGRect {
    
    
    mutating func styleBackGround(container: CGRect) {
        
        let x: CGFloat = 0
        let y: CGFloat = 0
        
        let w = container.width
        let h = container.height
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }

    
    mutating func styleLoginTable(_ container: CGRect)
    {
        let w = container.width*6/7
        let x = container.width/2-w/2
        let y = container.width/18 + 1/4*container.height
        let h = container.height - 1.1*y
        
        self = CGRect(x: x, y: y, width: w, height: h)
    }
    
    
    mutating func styleConfiguration(_ container: CGRect)
    {
        let h = container.height*0.8
        let w = h
        let x = container.width/2 - w/2
        let y = container.height/2 - h/2
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
        
    }
    
    
}
