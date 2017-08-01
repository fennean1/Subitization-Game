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
    
    let fontSize = StartButton.frame.height*0.7
    
    NextButton.setBackgroundImage(PinkButton, for: .normal)
    
    NextButton.titleLabel?.font = UIFont(name: "ChalkBoard SE", size: fontSize)
    
    NextButton.setTitle("Next", for: .normal)
    
    NextButton.setTitleColor(UIColor.white, for: .normal)
    
    hide(view: NextButton)
    
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
