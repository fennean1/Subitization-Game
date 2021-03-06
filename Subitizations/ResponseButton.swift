//
//  ResponseButton.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/21/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class responsebutton: UIButton {
    
    // Number of balls drawn in this button
    var _n = 0

    // The arraw of marble views that get drawn inside the button.
    var marbleViewArray: [UIImageView] = []
    
    func drawNumber(n: Int,image: UIImage) {
   
        _n = n
        
        let center  = CGPoint(x: self.frame.width/2, y: self.frame.width/2)
    
        
        // About to draw number shape 
        drawNumberShape(value: n, at: center, marbles: marbleViewArray, ballimage: image, marblesize: self.frame.width/5)
        
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    


        self.frame = frame
        
        // Initialize the marble view frame.
        for _ in 1...10
        {
            let newView = UIImageView()
            
            self.addSubview(newView)
            
            marbleViewArray.append(newView)
            
        }
    
        for marble in marbleViewArray {
            
            marble.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            
        }
   
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


