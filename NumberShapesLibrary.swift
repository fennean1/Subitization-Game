//
//  NumberShapesLibrary.swift
//  Subitizations
//
//  Created by Andrew Fenner on 8/19/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class _counter: UIImageView {
    
    
    
}


class _numbershape {
    
    var Counters: [_counter] = []
    
    var CountersOnView: [_counter] = []
    
    func drawSingleDigit(number: Int,at: CGPoint,ofSize: CGSize,withImage: UIImage) {
        
        print("this is the number i'm trying to draw",number)
        
       let pointsToDraw = centerNumberShapeCoordinates(atLocation: at, forValue: number, ofSize: ofSize)
        
        print("The Number Of Points We're Drawing Is:", pointsToDraw.count)
        
       for (i,c) in pointsToDraw.enumerated()
       {        
            Counters[i].center = c
            Counters[i].image = withImage
            Counters[i].frame.size = ofSize
        
        }
        
    }
    
    func drawTwoDigits(firstDigit: Int,secondDigit: Int, at: CGPoint, ofSize: CGSize,withImage: UIImage)
    {
        
        print("Passed into drawTwoDigits the values",firstDigit,"and",secondDigit)
        
        
        let centerOffset = CGPoint(x: 2.5*ofSize.width, y: 0)
        let firstDigitCenter = subtractPoints(a: at, b: centerOffset)
        let secondDigitCenter = addPoints(a: at, b: centerOffset)
        
        let pointsForFirstDigit = centerNumberShapeCoordinates(atLocation: firstDigitCenter, forValue: firstDigit, ofSize: ofSize)
        
       
        
        let pointsForSecondDigit = centerNumberShapeCoordinates(atLocation: secondDigitCenter, forValue: secondDigit, ofSize: ofSize)
        
        
        let pointsToDraw = pointsForFirstDigit + pointsForSecondDigit
        
        for (i,c) in pointsToDraw.enumerated()
        {
            Counters[i].center = c
            Counters[i].image = withImage
            Counters[i].frame.size = ofSize
            
        }
        
    }
    
    
    init(view: UIView) {
    
        for _ in 1...20
        {
            
            let newCounter = _counter()
            view.addSubview(newCounter)
            Counters.append(newCounter)
            
        }
        
        
        print("The number of counters has been initialized to:", Counters.count)
        
    }
    
    
}



// Call this and then add the array of images to your superview.
func centerNumberShapeCoordinates(atLocation: CGPoint, forValue: Int, ofSize: CGSize) -> [CGPoint] {
    
    print("We're getting centered coordinates for the value",forValue)
    
    let numberShapePoints = getOriginNumberShapePoints(forNumber: forValue, ofSize: ofSize)
    
    let centeredPointsAtLocation = numberShapePoints.flatMap({C in addPoints(a: C, b: atLocation)})

    return centeredPointsAtLocation
    
}


// Gets the size of a numbershape based on the points and counter size.
func getSizeOfShape(points: [CGPoint],counterSize: CGSize) -> CGSize
{
    let r = counterSize.width/2
    
    let leftX = minX(points: points) - r
    
    let rightX = maxX(points: points) + r
    
    let lowerY = minY(points: points) - r
    
    let upperY = maxY(points: points) + r
    
    let deltaX = abs(rightX - leftX)
    
    let deltaY = abs(upperY - lowerY)
    
    
    return CGSize(width: deltaX, height: deltaY)
    
}



// Returns a numbershape with the center at the origin.
func getOriginNumberShapePoints(forNumber: Int,ofSize: CGSize) -> [CGPoint] {
    
    print("We're trying to find the case for",a)
    
    var c: [CGPoint] = []
    
    // Size is read as the width or height since it will always be the same.(e.g. size = ofSize.height and size = ofSize.width)
    
    let size = ofSize.width
    
    switch forNumber {
        
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
        
        print("entered Case 3")
        
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
        
        print("We've entered the case for 10")
        
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
    
    // Create offset so that the center is placed at the origin.
    let shapeSize = getSizeOfShape(points: c, counterSize: ofSize)
    let offset = CGPoint(x: shapeSize.width/2, y: shapeSize.height/2)
    

    let pointsCenteredAtOrigin = c.flatMap({C in subtractPoints(a: C, b: offset)})

    print("Returning the number of points:",pointsCenteredAtOrigin.count)
    
    return pointsCenteredAtOrigin
    
}
