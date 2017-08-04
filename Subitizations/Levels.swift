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
    
    var myPerformanceData: [(Int,CGFloat,Int)] = [(1,0,0),(2,0,0),(3,0,0),(4,0,0),(5,0,0),(6,0,0),(7,0,0),(8,0,0),(9,0,0),(10,0,0)]
    
    var myCurrentLevel = Level()
    
    var myLevels: [Level] = []

    var Playing = false
    
    func makeMyLevels()
    {
        myLevels = initLevels()
        
    }
    
    func initPerformanceDataContext() {
        
        myPerformanceData = []
        
        for index in 0...9
        {
            let newTuple: (Int,CGFloat,Int)!
            
             newTuple = (index+1,CGFloat(index),index)
            
            myPerformanceData.append(newTuple)
        }
        
    }
    
    func updatePerfomanceDataFor(n: Int,with: CGFloat)
    {
        /*
        if myPerformanceData[n-1].1 == 0
        {
            myPerformanceData[n-1].1 = with
        }
        else{
        
            let newScore = (myPerformanceData[n-1].1+with)/2
        
            myPerformanceData[n-1].1 = newScore
        }
 
         */
        
        myPerformanceData[n-1].1 += with
        
    }
    
    
}

class game {
    
    var Levels: [Level] = []

}

struct Level {
    
    var index = 0
    var score = 0
    var problemSet: [Int] = []
    var difficulty: CGFloat = 0
    
    func getDifficulty(level: [Int]) -> Int
    {
        
        return level.reduce(0,+)
        
    }
    
}


var Levels: [Level] = []


func trophy(percentage: CGFloat) -> UIImage?
{
    print("Getting Trophy...")
    print("This is the percentage:",percentage)
    
    if percentage < 0.10
    {
        return LittleBlueTrophy
    }
    else if percentage < 0.30
    {
       return LittleGreenTrophy
    }
    else if percentage < 0.50
    {
        return MedBronzeTrophy
    }
    else if percentage < 0.70
    {
        return BigSilverTrophy
    }
    else if percentage < 0.90 {
        return GoldTrophy
    }
    else if percentage >= 0.90 {
        return RainbowTrophy
    }
    else
    {
        
        print("Did not find trophy for this criteria")
        
        return nil
    }
    
    
}
