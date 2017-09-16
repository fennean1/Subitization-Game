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


// I think this is for the grid...
func initBalls(number: Int,frame: CGRect) -> [touchableBall]
{
    
    var _balls: [touchableBall] = []
    
    for _ in 1...number
    {
        
        let newBall = touchableBall(frame: frame)
        
        _balls.append(newBall)
        
    }
    
    return _balls
    
}

