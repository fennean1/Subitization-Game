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

func initArray(size: Int,object: AnyObject) -> [AnyObject]
{
    var returnArray: [AnyObject] = []

    
    for _ in 1...size {
    
    let newElement: AnyClass = type(of: object)
 
    returnArray.append(newElement)
        
    }
    
    return returnArray
    
}

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


func initTimerLabel(container: CGRect)
{
    
    TimerLabel = UILabel()
    
    TimerLabel.frame.styleTimerLabel(container: container)
    TimerLabel.font = UIFont(name: "ChalkBoard SE", size: 20)
    TimerLabel.textAlignment = .center
        
}


func initScoreLabel(container: CGRect)
{
    
    ScoreLabel = UILabel()
    
    ScoreLabel.frame.styleScoreLabel(container: container)
    ScoreLabel.font = UIFont(name: "ChalkBoard SE", size: 70)
    ScoreLabel.textAlignment = .center

}

func initStartButton(container: CGRect)
{
    StartButton = UIButton()
    
    StartButton.frame.styleCenterButton(container: container)

    let fontSize = StartButton.frame.height*0.7
    
    StartButton.setBackgroundImage(PinkButton, for: .normal)
    
    StartButton.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: fontSize)
    
    StartButton.setTitle("Start", for: .normal)
    
    StartButton.setTitleColor(UIColor.white, for: .normal)
    
    
    
}


func initNextButton(container: CGRect)
{
    NextButton = UIButton()
    
    NextButton.frame.styleCenterButton(container: container)

    NextButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    let fontSize = StartButton.frame.height*0.7
    
    NextButton.setBackgroundImage(PinkButton, for: .normal)
    
    NextButton.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: fontSize)
    
    NextButton.setTitle("Next", for: .normal)
    
    NextButton.setTitleColor(UIColor.white, for: .normal)
    
    
    
}


// Initializes the marble array
func initMarbles(n: Int) {
    
    
    for _ in 1...n
    {
        
        let newMarble = marble(frame: DefaultFrame)
        
        newMarble.frame.size = CGSize(width: BallSize, height: BallSize)
        
        Marbles.append(newMarble)
        
    }
    
    
}




func initLevels() -> [Level] {
    
    var LevelTest: Level {
        
        var initLevel = Level()
        
        initLevel.index = 0
        
        initLevel.problemSet = [1,2,3,4,5,6,7,8,9,10]
        
        return initLevel
    }
    
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
    
    // let LevelZero = [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5]
    // let LevelOne = [1,1,1,3,3,3,5,5,5,7,7,7,9,9,9]
    // let LevelTwo = [2,2,2,4,4,4,6,6,6,8,8,8,10,10,10]
    // let LevelThree = [3,3,3,4,4,4,5,5,5,6,6,6,7,7,7]
    // let LevelFour = [4,4,4,5,5,5,6,6,6,7,7,7,8,8,8]
    // let LevelFive = [5,5,5,6,6,6,7,7,7,8,8,8,9,9,9,]
    // let LevelSix = [6,6,6,7,7,7,8,8,8,9,9,9,10,10,10]
    // let LevelSeven = [7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10]
    
    
}


