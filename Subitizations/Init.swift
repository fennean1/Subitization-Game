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




func initResponseButtons(container: CGRect) {
    
    
    for _ in 1...10
    {
        
        let newButton = responsebutton(frame: container)
        
        ResponseButtons.append(newButton)
        
    }
    
    
}

func initTrophyButtons(container: CGRect) {
    
    
    for index in 0...9
    {
        
        let newButton = trophybutton()
        
        newButton.level = index
        
        TrophyButtons.append(newButton)
        
    }
    
    
}


func initScoreLabel(container: CGRect)
{
    
    ScoreLabel = UILabel()
    
    ScoreLabel.frame.styleScoreLabel(container: container)
    ScoreLabel.font = UIFont(name: "ChalkBoard SE", size: 70)
    ScoreLabel.textAlignment = .center

}




// Initializes the marble array (currently always n = 10...but you never know.)
func initMarbles(n: Int) {
    
    for _ in 1...n
    {
        
        let newMarble = marble(frame: DefaultFrame)
        
        newMarble.frame.size = CGSize(width: BallSize, height: BallSize)
        
        Marbles.append(newMarble)
        
    }
    
    
}



// Instead of just declaring the levels as individual structs I made a function that creates new instances of them. This may not be necessary unless the levels store mutable data. So...probably not necessary.
func initLevels() -> [Level] {
    
    
    var LevelOne: Level {
        
        var initLevel = Level()
        
        initLevel.index = 0
        
        initLevel.problemSet = [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8,9,9,9,10,10,10]
        
        
        return initLevel
    }
    
    var LevelTwo: Level {
        
        var initLevel = Level()
        
        initLevel.index = 1
        
        initLevel.problemSet = [1,2,3,4,5,2,3,4,5,3,4,5,1]
        
        return initLevel
        
    }
    
    var LevelThree: Level {
        
        var initLevel = Level()
        
        initLevel.index = 2
        
        initLevel.problemSet = [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10]
        
        return initLevel
    }
    
    
     return [LevelOne,LevelTwo,LevelThree]
    
}


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

func initOriginalCoordinates()
{
    
    for _ in 0...19
    {
        originalCoordinates.append(CGPoint(x: 0, y: 0))
    }
    
}

