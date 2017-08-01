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

    var marbleViewArray: [UIImageView] = []
    
    func drawNumber(n: Int) {
    
        print("marble view array  count",marbleViewArray.count)
    
   
        _n = n
        
        let center  = CGPoint(x: self.frame.width/2, y: self.frame.width/2)
        
        for marble in marbleViewArray {
            
            marble.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            
        }
        
        // Avbout to draw number shape 
        drawNumberShape(value: n, at: center, marbles: marbleViewArray, ballimage: CurrentCounter, marblesize: self.frame.width/5)
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    

        self.frame = frame
        
        
        for _ in 1...10
        {
            let newView = UIImageView()
            
            self.addSubview(newView)
            
            marbleViewArray.append(newView)
            
        }
        
   
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



func getResponseButtonFrames(n: Int,container: CGRect) -> [CGRect]
{
    
    var frames: [CGRect] = []
    
    let side: CGFloat = container.width/12
    
    let length = side*CGFloat(n)*1.2
    
    let startX = container.width/2 - length/2
    
    for index in 0...n-1 {
        
   
        let x = 10 + startX + side*CGFloat(index)*1.2
        let y = container.height - 1.5*side
        
        let w = side
        let h = side
        
        frames.append(CGRect(x: x, y: y, width: w, height: h))
        
        
    }
    
    return frames
    
}

