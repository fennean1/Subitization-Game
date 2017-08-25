
//
//  File.swift
//  Obsolecense Management Plan
//
//  Created by Andrew Fenner on 4/18/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit




func distance(A: CGPoint,B: CGPoint) -> CGFloat
{
    
    let x1 = A.x
    let x2 = B.x
    
    let y1 = A.y
    let y2 = B.y
    
    let deltaX = x1-x2
    let deltaY = y1-y2
    
    let squaresum = deltaX*deltaX + deltaY*deltaY
    
    return sqrt(squaresum)
    
}

/* Pass the ball that may be swapped.
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
 */

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
                    
                    print("Stayed In Place")
                    
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
                    
                    // The balls are currently split.
                    Split = true
                    
                    let newpoints = decompose(a: a, b: b, frame: NumberShapeFrame.size)
                    
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
                //
                else if a == 10 || b == 10 || stayedInPlace
                {
                    print("One of them was ten or the ball stayed in place")
                    
                    UIView.animate(withDuration: 0.5, animations: { self.center = self.originalPlace})
                }
            }
        }
        // Fix: SHould be something like "Updated Bounced Centers" since it's always operating on the global Balls array.
        bouncedBallCenters = bounceBallCenters()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if colorSwitching
        {
            self.image = counterimage
            
        }
        
        let index = Balls.index(of: self)
        
        
        // THIS IS WHERE THE "NUDGING" ERROR COMES FROM.
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


// Arranges any number for viewing within a frame (may consist of more than one numbershapes i.e. two digit numbers & compositions)
func numbershapeviewXY(a: Int, frame: CGSize)-> [CGPoint] {
    
    var c: [CGPoint] = []
    
    let ball = ballsize(frame: frame)
    
    switch a <= 10 {
        
    case true:
        
        let shapeoffset = getShapeCenterOffset(a: a, ballsize: ball.width, points: [])
        
        
        let shx = frame.width/2 - shapeoffset.x
        let shy = frame.height/2 - shapeoffset.y
        let offsetpoint = CGPoint(x: shx, y: shy)
        
        c = numbershapeXY(a: a, frame: ball)
        
        c = c.map({a in addPoints(a: a, b: offsetpoint)})
        
        
    case false:
        
        
        var o = a%10
        var t = a-o
        
        
        if a == 20
        {
            o = 10
            t = 10
        }
        
        
        c = decompose(a: t, b: o, frame: frame)
        
    }
    
    return c
    
}



// A view for representing numbershapes. **Always init with width = 2 X Height**
class numbershapeview: UIView {
    
    
    
    // Images views of balls currently on the card (initially zero)
    
    func composeNumber(a: Int) {
        
        let points = numbershapeviewXY(a: a, frame: self.frame.size)
        
        
        animateto(coordinates: points)
        
    }
    
    func splitNumber(a: Int, b: Int) {
        
        let points = decompose(a: a, b: b, frame: self.frame.size)
        
        animateto(coordinates: points)
        
    }
    
    
    // pass this a set of coordinates that you want to animate to (must initialize first)
    func animateto(coordinates: [CGPoint]){
        
        
        for (index,_) in Balls.enumerated()
        {
            if index < coordinates.count
            {
                
                originalCoordinates[index] = coordinates[index]
                
            }
            else
            {
                let hiddenPoint = CGPoint(x: -BallDim, y: -BallDim)
                
                
                originalCoordinates[index] = subtractPoints(a: hiddenPoint, b: numbershapeViewOrigin)
            }
            
        }
        
        // Offset coordinates to align inside view
        var newcoordinates = coordinates.map{addPoints(a: $0, b: self.frame.origin)}
        
        
        // MOOOOOOOOOOOOO
        var coordinatesinplay = coordinates.count
        
        
        let oldBallsInplay = BallsInPlay
        
        print(oldBallsInplay,"oldballs")
        
        print(coordinatesinplay,"coordinatesinplay")
        
        
        // Logic for adding or removing objects when the number of coordinates have changed. If we received more coordinates that there are balls on the board, we need to add more.
        
        if coordinatesinplay > oldBallsInplay {
            
            
            // Finally, animate to the new coordinates.
            UIView.animate(withDuration: 0.5, animations:{
                
                
                for index in 0...newcoordinates.count-1 {
                    
                    print("addingballs")
                    
                    Balls[index].frame.size = CGSize(width: BallDim, height: BallDim)
                    Balls[index].center = newcoordinates[index]
                    
                    if index >= oldBallsInplay
                    {
                        print("greater than old balls")
                        Balls[index].image = counterimage
                    }
                    
                }
                
            })
            
            
        }
            // if we have fewer coordinates than we do balls, we must remove objects
        else if coordinatesinplay < oldBallsInplay {
            
            
            
            print("I am now about to remove balls")
            
            UIView.animate(withDuration: 0.5, animations: {
                
                let top = oldBallsInplay-1
                
                for (index,aBall) in Balls.enumerated() {
                    
                    if index >= top
                    {
                        coordinatesinplay = coordinatesinplay - 1
                        print("Removed a Ball at \(index)")
                        aBall.frame.origin = CGPoint(x: -BallDim, y: -BallDim)
                        aBall.frame.size = CGSize(width: 0, height: 0)
                    }
                    else{
                        
                        aBall.center = newcoordinates[index]
                        
                    }
                    
                    
                }
                
            })
            
            
        }
        else{
            
            
            UIView.animate(withDuration: 0.5, animations:{
                
                for index in 0...coordinates.count-1 {
                    
                    Balls[index].frame.size = CGSize(width: BallDim, height: BallDim)
                    Balls[index].center = newcoordinates[index]
                    
                }
                
            })
            
            
        }
        
        
        
    }
    
    
}


