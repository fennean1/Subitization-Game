//
//  Init.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/13/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//


// This file contains logic related to the initilazation of properties & objects.

import Foundation
import UIKit


func getConfigurationFrame(frame: CGRect) -> CGRect
{
    
    let h = frame.height*0.8
    let w = h
    let x = frame.width/2 - w/2
    let y = frame.height/2 - h/2
    
    return CGRect(x: x, y: y, width: w, height: h)
    
}

func initConfigurationNodes(frame: CGRect) -> [CGPoint]
{
    let r = frame.width/20
    var nodes: [CGPoint] = []
    
    for dy in 0...9
    {
        for dx in 0...9
        {
            let x = r + CGFloat(dx)*2*r
            let y = r + CGFloat(dy)*2*r
            
            nodes.append(CGPoint(x: x, y: y))
            
        }
        
        
    }
    
    return nodes
    
}


// Initializes the marble array
func initMarbles(n: Int) {
    
    
    for _ in 0...n-1
    {
        
        let newImage = UIImageView()
        
        newImage.frame.size = CGSize(width: 2*R, height: 2*R)
        
        Marbles.append(newImage)
        
    }
    
    
}
