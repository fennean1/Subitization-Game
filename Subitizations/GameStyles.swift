//
//  GameStyles.swift
//  Subitizations
//
//  Created by Andrew Fenner on 9/16/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit



extension CGRect {
    
    
    mutating func styleScoreLabel(container: CGRect)
    {
        
        let h = container.height/7
        let w = 0.8*container.width
        
        let y = h
        let x = container.width/2 - w/2
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    mutating func styleInGameTrophyView(container: CGRect)
    {
        
        let h = container.height/7
        let w = h
        
        let y = h/2
        let x = container.width/2 - w/2
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    mutating func styleCenterButton(container: CGRect) {
        
        
        let w = container.width/4
        let h = w/4
        
        let x = container.width/2 - w/2
        let y = container.height - container.width/4
        
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
        
    }

    mutating func styleNextButton(container: CGRect)
    {
        
        let h = container.height/6.5
        let w = h
        
        let y = container.height/2 - h/2
        let x = container.width - 1.5*w
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }

    mutating func styleHideNextButton(container: CGRect)
    {
        
        let h = container.height/5
        let w = h
        
        let y = container.height/2 - h/2
        let x = container.width + 1.5*w
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
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
