//
//  Numbershape.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/22/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


func drawNumberShape(value: Int,at: CGPoint, marbles: [UIImageView],ballimage: UIImage, marblesize: CGFloat) {
    

    
    // We're not going to deal with anything where the balls array is not size ten and the number we're drawing is greater than ten. If we want to draw numbershapes with values greater than 10 we need nesting
    guard value <= 10, marbles.count == 10 else {

        
        
        print("The size of your array must be 10 and the value you draw must be less than or equal to ten. Your array is ",marbles.count,"and your value is",value)
        
        return
        
    }
    
    var points = decompose(a: value, side: marblesize)
    
    let sizeOfShape = _getShapeSize(points: points, r: marblesize/2)
    
    let shapeOffset = CGPoint(x: sizeOfShape.width/2, y: sizeOfShape.height/2)
    
    let combinedOffset = subtractPoints(a: at, b: shapeOffset)
    

    points = points.map({C in addPoints(a: C, b: at)})


    for (index,ball) in marbles.enumerated() {
        
        var drawBall: Bool {return index < value}
        
        
        if drawBall {
            
    
            ball.isHidden = false
            
            ball.frame.size = CGSize(width: marblesize, height: marblesize)
            
            
            print("Setting Ball image to",ballimage)
            ball.image = CurrentCounter
            
            
            UIView.animate(withDuration: 0.5, animations: {
      
                ball.center = points[index]
                
            })
            
            }
            else {
            
            ball.isHidden = true
            
        }
        
        
        
    }
    
    
}


// Get the coordinates for placing a number inside of the square view.
func decompose(a: Int, side: CGFloat) -> [CGPoint]
{
    
    
    let ballSize = CGSize(width: side, height: side)
    
    // Size of number a

 
    // Set of points for number 'a'
    let ap = numbershapeXY(a: a, frame: ballSize)
    
    let aSize = _getShapeSize(points: ap, r: side/2)
    
    // Numbershape coordinates are created with origin on the upper left. To center the entire shape around this origin we need to apply an offset equal to half the shapes height and width.
    let offSet = CGPoint(x: aSize.width/2, y: aSize.height/2)
    
    
    // Apply offset
    let adjap = ap.flatMap({C in subtractPoints(a: C, b: offSet)})

    
    
    return adjap
    
}




// Finds and array of centers for the pre-defined numbershapes in terms of value and ball size
func numbershapeXY(a: Int,frame: CGSize) -> [CGPoint] {
    
    var c: [CGPoint] = []
    let size = frame.width
    
    switch a {
        
    // Coordinates for One Ball
    case 0:
        
        c = []
        
    case 1:
        
        // First Position
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
    // Coordinates for Two Balls
    case 2:
        
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        let x2 = size/2
        let y2 = size/2 + size
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
    // Coordinates for Three Balls
    case 3:
        
        
        // Top Ball
        let x1 = size
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Bottom Left
        let x2 = size/2
        let y2 = size/2 + size*COS30
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Bottom Right
        let x3 = size + size/2
        let y3 = size/2 + size*COS30
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        
    case 4:
        
        // Top Left
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Top Right
        let x2 = size/2 + size
        let y2 = size/2
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Bottom Left
        let x3 = size/2
        let y3 = size/2 + size
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        // Bottom Right
        let x4 = size/2 + size
        let y4 = size/2 + size
        let point4 = CGPoint(x: x4,y: y4)
        c.append(point4)
        
    case 5:
        
        let containerwidth = size+2*size*COS45
        
        // Top Left
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Top Right
        let x2 = containerwidth - size/2
        let y2 = size/2
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Middle
        let x3 = containerwidth/2
        let y3 = containerwidth/2
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        // Bottom Left
        let x4 = size/2
        let y4 = containerwidth-size/2
        let point4 = CGPoint(x: x4,y: y4)
        c.append(point4)
        
        // Bottom right
        let x5 = containerwidth-size/2
        let y5 = containerwidth-size/2
        let point5 = CGPoint(x: x5,y: y5)
        c.append(point5)
        
    case 6:
        
        // Top Left
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Top Right
        let x2 = size/2 + size
        let y2 = size/2
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Middle Left
        let x3 = size/2
        let y3 = size/2 + size
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        // Middle Right
        let x4 = size/2 + size
        let y4 = size/2 + size
        let point4 = CGPoint(x: x4,y: y4)
        c.append(point4)
        
        // Bottom Left
        let x5 = size/2
        let y5 = size/2 + 2*size
        let point5 = CGPoint(x: x5,y: y5)
        c.append(point5)
        
        // Bottom Right
        let x6 = size/2 + size
        let y6 = size/2 + 2*size
        let point6 = CGPoint(x: x6,y: y6)
        c.append(point6)
        
        
    // Coordinates for 7 balls
    case 7:
        
        
        // Top Left Ball
        let x1 = size
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Top Left Ball
        let x2 = 2*size
        let y2 = size/2
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Bottom Left
        let x3 = size/2
        let y3 = size/2 + size*COS30
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        // Bottom Middle
        let x4 = size + size/2
        let y4 = size/2 + size*COS30
        let point4 = CGPoint(x: x4,y: y4)
        c.append(point4)
        
        // Bottom Right
        let x5 = 2*size + size/2
        let y5 = size/2 + size*COS30
        let point5 = CGPoint(x: x5,y: y5)
        c.append(point5)
        
        // Bottom Left
        let x6 = size
        let y6 = size/2 + 2*size*COS30
        let point6 = CGPoint(x: x6,y: y6)
        c.append(point6)
        
        // Bottom Left
        let x7 = 2*size
        let y7 = size/2 + 2*size*COS30
        let point7 = CGPoint(x: x7,y: y7)
        c.append(point7)
        
        
    case 8:
        
        // Top Left
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1, y: y1)
        c.append(point1)
        
        // Top Left
        let x2 = size/2 + size
        let y2 = size/2
        let point2 = CGPoint(x: x2, y: y2)
        c.append(point2)
        
        // Top Left
        let x3 = size/2 + 2*size
        let y3 = size/2
        let point3 = CGPoint(x: x3, y: y3)
        c.append(point3)
        
        // Middle left
        let x4 = size
        let y4 = size/2 + size*COS30
        let point4 = CGPoint(x: x4, y: y4)
        c.append(point4)
        
        // Middle right
        let x5 = 2*size
        let y5 = size/2 + size*COS30
        let point5 = CGPoint(x: x5, y: y5)
        c.append(point5)
        
        // Top Left
        let x6 = size/2
        let y6 = size/2 + 2*size*COS30
        let point6 = CGPoint(x: x6, y: y6)
        c.append(point6)
        
        // Top Left
        let x7 = size/2 + size
        let y7 = size/2 + 2*size*COS30
        let point7 = CGPoint(x: x7, y: y7)
        c.append(point7)
        
        // Top Left
        let x8 = size/2 + 2*size
        let y8 = size/2 + 2*size*COS30
        let point8 = CGPoint(x: x8, y: y8)
        c.append(point8)
        
    case 9:
        
        // Top Left
        let x1 = size/2
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Top Middle
        let x2 = size/2 + size
        let y2 = size/2
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Top Right
        let x3 = size/2 + 2*size
        let y3 = size/2
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        // Middle Left
        let x4 = size/2
        let y4 = size/2 + size
        let point4 = CGPoint(x: x4,y: y4)
        c.append(point4)
        
        // Middle Middle
        let x5 = size/2 + size
        let y5 = size/2 + size
        let point5 = CGPoint(x: x5,y: y5)
        c.append(point5)
        
        // Middle Right
        let x6 = size/2 + 2*size
        let y6 = size/2 + size
        let point6 = CGPoint(x: x6,y: y6)
        c.append(point6)
        
        // Bottom Left
        let x7 = size/2
        let y7 = size/2 + 2*size
        let point7 = CGPoint(x: x7,y: y7)
        c.append(point7)
        
        // Bottom Middle
        let x8 = size/2 + 2*size
        let y8 = size/2 + 2*size
        let point8 = CGPoint(x: x8,y: y8)
        c.append(point8)
        
        // Bottom Right
        let x9 = size/2 + size
        let y9 = size/2 + 2*size
        let point9 = CGPoint(x: x9,y: y9)
        c.append(point9)
        
        
    case 10:
        
        // Top
        let x1 = 2*size
        let y1 = size/2
        let point1 = CGPoint(x: x1,y: y1)
        c.append(point1)
        
        // Second row_1
        let x2 = size + size/2
        let y2 = size/2 + size*COS30
        let point2 = CGPoint(x: x2,y: y2)
        c.append(point2)
        
        // Second row_2
        let x3 = 2*size + size/2
        let y3 = size/2 + size*COS30
        let point3 = CGPoint(x: x3,y: y3)
        c.append(point3)
        
        // Third row_1
        let x4 = size
        let y4 = size/2 + 2*size*COS30
        let point4 = CGPoint(x: x4,y: y4)
        c.append(point4)
        
        // Third row_2
        let x5 = 2*size
        let y5 = size/2 + 2*size*COS30
        let point5 = CGPoint(x: x5,y: y5)
        c.append(point5)
        
        // Third row_3
        let x6 = 3*size
        let y6 = size/2 + 2*size*COS30
        let point6 = CGPoint(x: x6,y: y6)
        c.append(point6)
        
        // Fourth row_1
        let x7 = size/2
        let y7 = size/2 + 3*size*COS30
        let point7 = CGPoint(x: x7,y: y7)
        c.append(point7)
        
        // Fourth row_2
        let x8 = size/2 + size
        let y8 = size/2 + 3*size*COS30
        let point8 = CGPoint(x: x8,y: y8)
        c.append(point8)
        
        // Fourth row_3
        let x9 = size/2 + 2*size
        let y9 = size/2 + 3*size*COS30
        let point9 = CGPoint(x: x9,y: y9)
        c.append(point9)
        
        
        // Fourth row_4
        let x10 = size/2 + 3*size
        let y10 = size/2 + 3*size*COS30
        let point10 = CGPoint(x: x10,y: y10)
        c.append(point10)
        
        
    default:
        
        print("This number was not found in the coordinates cases")
        
    }
    
    return c
    
}


func _getShapeSize(points: [CGPoint],r: CGFloat) -> CGSize
{
 
    let leftX = minX(points: points) - r
    
    let rightX = maxX(points: points) + r
    
    let lowerY = minY(points: points) - r
    
    let upperY = maxY(points: points) + r
    
    let deltaX = abs(rightX - leftX)
    
    let deltaY = abs(upperY - lowerY)
    
    
    return CGSize(width: deltaX, height: deltaY)
    
    
}


//Gets the width and height of any numbershape based on the number and the ballsize
func getShapeSize(a: Int, ballsize: CGFloat)-> CGSize {
    
    var size: CGSize!
    
    switch a {
        
    case 1:
        
        size = CGSize(width: ballsize, height: ballsize)
        
    case 2:
        
        let w = ballsize
        let h = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 3:
        
        let h = 2*ballsize*COS30
        let w = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 4:
        
        let h = 2*ballsize
        let w = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 5:
        
        let h = ballsize+2*ballsize*COS45
        let w = ballsize+2*ballsize*COS45
        
        size = CGSize(width: w, height: h)
        
        
    case 6:
        
        let h = 3*ballsize
        let w = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 7:
        
        let h = 2*ballsize*COS30+ballsize
        let w = 3*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 8:
        
        let h = 2*ballsize*COS30+ballsize
        let w = 3*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 9:
        
        let h = 3*ballsize
        let w = 3*ballsize
        
        size = CGSize(width: w, height: h)
        
        
    case 10:
        
        let h = ballsize + 3*ballsize*COS30
        let w = 4*ballsize
        
        size = CGSize(width: w, height: h)
        
        
    default:
        
        print("didn't find anything")
        size = CGSize(width: 0, height: 0)
        
    }
    
    
    return size
    
}






// Gets the width and height of any numbershape based on the number and the ballsize
func getShapeDimensions(a: Int, ballsize: CGFloat)-> CGSize {
    
    var size: CGSize!
    
    switch a {
        
    case 1:
        
        size = CGSize(width: ballsize, height: ballsize)
        
    case 2:
        
        let w = ballsize
        let h = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 3:
        
        let h = 2*ballsize*COS30
        let w = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 4:
        
        let h = 2*ballsize
        let w = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 5:
        
        let h = ballsize+2*ballsize*COS45
        let w = ballsize+2*ballsize*COS45
        
        size = CGSize(width: w, height: h)
        
        
    case 6:
        
        let h = 3*ballsize
        let w = 2*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 7:
        
        let h = 2*ballsize*COS30+ballsize
        let w = 3*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 8:
        
        let h = 2*ballsize*COS30+ballsize
        let w = 3*ballsize
        
        size = CGSize(width: w, height: h)
        
    case 9:
        
        let h = 3*ballsize
        let w = 3*ballsize
        
        size = CGSize(width: w, height: h)
        
        
    case 10:
        
        let h = ballsize + 3*ballsize*COS30
        let w = 4*ballsize
        
        size = CGSize(width: w, height: h)
        
        
    default:
        
        print("didn't find anything")
        size = CGSize(width: 0, height: 0)
        
    }
    
    
    return size
    
}














