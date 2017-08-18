//
//  File.swift
//  Subitizations
//
//  Created by Andrew Fenner on 8/16/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


/*
class touchableBall: UIImageView {
    
    
    var outOfPlace = false
    
    var originalPlace: CGPoint!
    
    
    
    func panhandle(_ sender: UIPanGestureRecognizer)
    {
        
        
        let translation = sender.translation(in: sender.view)
        
        if let view = sender.view
        {
            
            view.center = CGPoint(x: (view.center.x + translation.x),
                                  y: view.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: sender.view)
        }
        
        
        
        
        
        
        if sender.state == .ended
        {
            
            // If the balls haven't been scattered and the movement distance is great than a ball radius.
            if Scattered == false && (distance(A: originalPlace, B: self.center) > r) {
                
                var wentToRight: Bool {
                    
                    let returnValue = originalPlace.x <= centerOfScreen.x && self.center.x >= centerOfScreen.x
                    
                    print("Did I go to the right?",returnValue)
                    
                    return returnValue
                    
                }
                
                var wentToLeft: Bool {
                    
                    let returnValue  = originalPlace.x >= centerOfScreen.x && self.center.x  <= centerOfScreen.x
                    
                    
                    print("Did I go to the left?",returnValue)
                    
                    return returnValue
                    
                }
                
                let stayedLeft  = originalPlace.x <= centerOfScreen.x && self.center.x  <= centerOfScreen.x
                
                let stayedRight = originalPlace.x >= centerOfScreen.x && self.center.x >= centerOfScreen.x
                
                var stayedInPlace: Bool {
                    
                    return stayedLeft || stayedRight
                    
                }
                
                let points = Balls.map({(value: touchableBall) -> CGFloat in return distance(A: value.center, B: self.center)})
                
                let minDistance = points.sorted()[1]
                
                if minDistance < r  &&  Scattered == false {
                    
                    swapBall(b: self)
                    
                }
                else if (minDistance > r && wentToLeft && a < 10) || (a == BallsInPlay && stayedLeft) {
                    
                    
                    
                    
                    if b == 0
                    {
                        
                        let _a = a
                        a = b
                        b = _a
                        
                    }
                    
                    a = a + 1
                    b = b - 1
                    
                    
                    let newpoints = decompose(a: a, b: b, frame: NumberShapeFrame.size)
                    
                    Split = true
                    
                    let oldIndex = Balls.index(of: self)
                    
                    Balls.insert(self, at: 0)
                    
                    Balls.remove(at: oldIndex!+1)
                    
                    
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        for index in 0...newpoints.count-1
                        {
                            let newPoint = addPoints(a: newpoints[index],b: numbershapeViewOrigin)
                            
                            Balls[index].center = newPoint
                            
                            originalCoordinates[index] = subtractPoints(a: newPoint, b: numbershapeViewOrigin)
                            
                        }
                        
                    })
                    
                }
                else if (minDistance > r && wentToRight && b < 10) || (b == 0 && stayedRight)
                {
                    
                    print("Turns out my ball went to the right!")
                    
                    print("this is b",b)
                    
                    
                    print("I've entered and this is b:",b)
                    
                    a = a - 1
                    b = b + 1
                    
                    
                    let selfIndex = Balls.index(of: self)
                    
                    Balls.insert(self, at: BallsInPlay)
                    
                    Balls.remove(at: selfIndex!)
                    
                    let newpoints = decompose(a: a, b: b, frame: NumberShapeFrame.size)
                    
                    Split = true
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        for index in 0...newpoints.count-1
                        {
                            let newPoint = addPoints(a: newpoints[index],b: numbershapeViewOrigin)
                            
                            Balls[index].center = newPoint
                            
                            print(index,"Index")
                            
                            print(originalCoordinates.count,"Original Coordinates")
                            
                            originalCoordinates[index] = subtractPoints(a: newPoint, b: numbershapeViewOrigin)
                            
                        }
                        
                        
                    })
                    
                }
                    // If
                else if a == 10 || b == 10 || stayedInPlace
                {
                    print("One of them was ten and the ball stayed in place")
                    
                    UIView.animate(withDuration: 0.5, animations: { self.center = self.originalPlace})
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if colorSwitching
        {
            self.image = counterimage
            
        }
        
        let index = Balls.index(of: self)
        
        originalPlace = Balls[index!].center
        
    }
    
    
    
    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panhandle))
        pan.cancelsTouchesInView = false
        self.frame = frame
        self.addGestureRecognizer(pan)
        self.isUserInteractionEnabled = true
        self.image = counterimage
    }
    
    
}

*/


// Pass the ball that may be swapped.
func swapBall(b: touchableBall)
{
    
    let indexOfMover = Balls.index(of: b)
    
    // Get all the distances.
    let points = Balls.map({(value: touchableBall) -> CGFloat in return distance(A: value.center, B: b.center)})
    
    let minDistance = points.sorted()[1]
    
    print("minimum distance",minDistance)
    
    if minDistance < r && Scattered == false
    {
        
        
        let indexOfClosest = points.index(of: minDistance)
        
        var newMoverCenter = originalCoordinates[indexOfClosest!]
        var newCenterForClosest = originalCoordinates[indexOfMover!]
        
        let mover = b
        let closest = Balls[indexOfClosest!]
        
        //originalCoordinates[indexOfClosest!] = newCenterForClosest
        //originalCoordinates[indexOfMover!] = newMoverCenter
        
        
        
        newMoverCenter = addPoints(a: numbershapeViewOrigin, b: newMoverCenter)
        newCenterForClosest = addPoints(a: numbershapeViewOrigin, b: newCenterForClosest)
        
        
        UIView.animate(withDuration: 0.5, animations: {
            
            print("moving To",newMoverCenter)
            
            
            b.center = newMoverCenter
            Balls[indexOfClosest!].center = newCenterForClosest
            
            
        })
        
        
        Balls[indexOfClosest!] = mover
        Balls[indexOfMover!] = closest
        
    }
    else if Scattered == false  {
        
        UIView.animate(withDuration: 0.5, animations: { Balls[indexOfMover!].center = addPoints(a: originalCoordinates[indexOfMover!], b: numbershapeViewOrigin) })
        
    }
    
    
    
}


