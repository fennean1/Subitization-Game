//
//  Targets.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/25/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class player {
    
  
    var myName = "Jimmy"
    
    
    // Performance data lasts the lifetime of a game
    var myPerformanceData: [(Int,CGFloat,Int)] = [(1,0,0),(2,0,0),(3,0,0),(4,0,0),(5,0,0),(6,0,0),(7,0,0),(8,0,0),(9,0,0),(10,0,0)]

    var playing = false
    
    // So that performance data can be reinitialized each game.
    func initPerformanceDataContext() {
        
        myPerformanceData = []
        
        for index in 0...9
        {
            let newTuple: (Int,CGFloat,Int)!
            
             newTuple = (index+1,0,0)
            
            myPerformanceData.append(newTuple)
        }
        
    }
    
    
    // Still working on the algorithm for calculating performance data.
    func updatePerfomanceDataFor(n: Int,with: CGFloat)
    {
        
        myPerformanceData[n-1].1 += with
        
    }
    
    
}



func getTrophy(percentage: CGFloat) -> UIImage?
{
    print("Getting Trophy...")
    print("This is the percentage:",percentage)
    
    if percentage < 0.25
    {
        return LittleBlueTrophy
    }
    else if percentage < 0.35
    {
       return LittleGreenTrophy
    }
    else if percentage < 0.45
    {
        return MedBronzeTrophy
    }
    else if percentage < 0.55
    {
        return BigSilverTrophy
    }
    else if percentage < 0.65 {
        return GoldTrophy
    }
    else if percentage >= 0.65 {
        return RainbowTrophy
    }
    else
    {
        
        print("Did not find trophy for this criteria")
        
        return nil
    }
    
    
}
