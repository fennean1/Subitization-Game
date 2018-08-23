


// --- Convenience: For methods and constants designed to support other functions and make them more convenient.


import Foundation
import UIKit
import Darwin


// Returns a cosine with type CGFloat for doing coordinate calculations
func cosine(arg: Double)-> CGFloat {
    
    return CGFloat(cos(arg))
    
}

let RectZero = CGRect(x: 0, y: 0, width: 0, height: 0)

// Give the ballsize as a function of the frame. Optimally set to an eighth of the width
func ballsize(frame: CGSize) -> CGSize {
    
    let h = frame.height/5
    let w = h
    
    return CGSize(width: h, height: w)
    
}


// Frame used for initialization when () constructor needs an arguement
let DefaultFrame = CGRect(x: 0, y: 0, width: 10, height: 10)

let Clouds = UIImage(named: "Clouds")


// Gets the available nodes for a set of points that contain counters of radius 'r'
func getNodes(r: CGFloat,points: [CGPoint]) -> [CGPoint]
{
    var nodes: [CGPoint] = []
    
    for aPoint in points
    {
        nodes = nodes + boundaryNodes(p: aPoint, delta: 2*r)
    }
    
    return nodes
    
}

// Finds duplicates in an array based on an arbitrary criteria
extension Array {
    
    func filterDuplicates(includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        
        // Empty array that we'll populate with unique elements.
        var results = [Element]()
        
        forEach { (element) in
            // Check to see if element is already in the array by removing everything that's not equal to the element.
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            // Append to the results array if it has no matches in our existing array.d
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
}

extension Array {
    
    func thing()
    {
        forEach { (x) in
            print(x)
        }
        
    }
    
}

// Finds the four points (left, right, up and down) that are at distance 'delta' from 'p'
func boundaryNodes(p: CGPoint,delta: CGFloat) -> [CGPoint] {

    let deltaPlusX = CGPoint(x: p.x+delta, y: p.y)
    let deltaMinusX = CGPoint(x: p.x-delta, y: p.y)
    let deltaPlusY = CGPoint(x: p.x, y: p.y+delta)
    let deltaMinusY = CGPoint(x: p.x, y: p.y-delta)
    
    
    return [deltaPlusY,deltaPlusX,deltaMinusY,deltaMinusX]
    
}


func getOffsetForConfiguration(points: [CGPoint],r: CGFloat) -> CGPoint {
    
    
    let leftX = minX(points: points) - r

    let rightX = maxX(points: points) + r
   
    let lowerY = minY(points: points) - r
    
    let upperY = maxY(points: points) + r
    
    let offX = (rightX + leftX)/2
    
    let offY = (upperY + lowerY)/2
    
    
    return CGPoint(x: -offX, y: -offY)
    
}

func getMarbleFromColorState(state: colorstate) -> UIImage
{
    
    switch state {
        
    case .blue:
        
        return BlueBall
        
    case .orange:
        
        return OrangeBall
    
    case .red:
        
        return RedBall
        
    case .pink:
        
        return PinkBall
    
    case .purple:
        
        return PurpleBall
    
    case .green:
        
        return GreenBall
        
    case .nothing:
        
        return NoBall
        
    }
    
}

func getShapeSize(points: [CGPoint],counterSize: CGSize) -> CGSize
{
    let xPadding = counterSize.width/2
    let yPadding = counterSize.height/2
    
    let leftX = minX(points: points) - xPadding
    
    let rightX = maxX(points: points) + xPadding
    
    let lowerY = minY(points: points) - yPadding
    
    let upperY = maxY(points: points) + yPadding
    
    let w = rightX - leftX
    
    let h = upperY - lowerY

    return CGSize(width: w, height: h)

}


// Calculates the minimum x value given a set a points.
func minX(points: [CGPoint]) -> CGFloat{
    
    let X = points.map({(point: CGPoint) -> CGFloat in return point.x})
    
    return X.min()!
    
}

func maxX(points: [CGPoint])-> CGFloat{
    
    let X = points.map({(point: CGPoint) -> CGFloat in return point.x})
    
    return X.max()!
    
}

func minY(points: [CGPoint]) -> CGFloat{
    
    let Y = points.map({(point: CGPoint) -> CGFloat in return point.y})
    
    return Y.min()!
    
}

func maxY(points: [CGPoint]) -> CGFloat {
    
    let Y = points.map({(point: CGPoint) -> CGFloat in return point.y})
    
    return Y.max()!
    
}



// Takes an array of points and finds the closest index relative to another point.
func indexOfnearestPoint(point: CGPoint,otherpoints: [CGPoint]) -> CGPoint
{
    // Array of the distances between the point being examined and the array of points.
    let distances = otherpoints.map({(value: CGPoint)-> CGFloat in return distance(A: point, B: value)})
    
    // Minimum value of distances.
    let minimumDistance = distances.min()
    

    
    // Get the index of the minimum distance.
    let indexOfMin = distances.index(of: minimumDistance!)
    
    return otherpoints[indexOfMin!]
    
}


// For extracting a random element from an array.
extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}


// Defines an operation that adds two points together
func addPoints(a: CGPoint,b: CGPoint) -> CGPoint {
    
        
    let ax = a.x
    let ay = a.y
    
    let bx = b.x
    let by = b.y
    

    return CGPoint(x: ax+bx,y: ay+by)
    
    
}

// Defines an operation that subtracts two points together
func subtractPoints(a: CGPoint,b: CGPoint) -> CGPoint {
    
    
    
    let ax = a.x
    let ay = a.y
    
    let bx = b.x
    let by = b.y
    
    
    
    return CGPoint(x: ax-bx,y: ay-by)
    
    
}


// Removes duplicate nodes if they are m
func removeDuplicateNodes(nodes: [CGPoint]) -> [CGPoint] {
    
    
    
    // Function that gives the criteria for duplicates
    func duplicateCriteria(pointA: CGPoint, pointB: CGPoint) -> Bool
    {
        // Points are duplicates if the distance between them is non zero and less than one pixel.
        
        let d = distance(A: pointA, B: pointB)
        
        return abs(d) < 5
        
    }
    
    let filteredArray = nodes.filterDuplicates(includeElement: {duplicateCriteria(pointA: $0, pointB: $1)})
    
    print("NODES REMOVED:",nodes.count-filteredArray.count)
    
    return filteredArray
    
    
}

func hide(view: UIView)
{
    UIView.animate(withDuration: 0.5 , animations: {view.center = CGPoint(x: -100,y: -100)})
    
}


func calculateScore(dT: CGFloat,number: Int,penalty: CGFloat) -> Int {
    
    var score: CGFloat = 0
    
    // Adjusted to increase penalty for wrong answer.
    score = 200/(sqrt(dT + 1 + 2*CGFloat(penalty)))

    
    return Int(score)
    
}

// Multiplies a point by a scalar as if it were a vector.
func scalePoints(factor: CGFloat,vector: CGPoint) -> CGPoint {
    
    let x = factor*vector.x
    let y = factor*vector.y
    
    return CGPoint(x: x, y: y)
    
}

func bouncePoints(points: [CGPoint],center: CGPoint) -> [CGPoint] {
    
    var returnArr: [CGPoint] = []
    
    for point in points {
        
        let length = distance(A: point, B: center)

        let vector = subtractPoints(a: point, b: center)  
        
        let bounce: CGFloat = 40
        
        let direction = scalePoints(factor: bounce/(length+1),vector: vector)
  
        let newPoint = addPoints(a: direction, b: point)
        
        returnArr.append(newPoint)

        
    }
    
    return returnArr
    
}




var MarbleImages: [UIImage] = [BlueBall,PinkBall,RedBall,PurpleBall,OrangeBall,GreenBall]


func getMeshCenter(mesh: [CGPoint]) -> CGPoint {
    
    
    let right  = maxX(points: mesh)
    let top = maxY(points: mesh)
    let left = minX(points: mesh)
    let bottom = minY(points: mesh)
    
    let x = (right - left)/2
    let y = (top - bottom)/2
    
    return CGPoint(x: x, y: y)
    
    
}

// CG point is equatable but has not been working consistently. Redefining so that points are considered identical so long as they are less than one pixel apart.
func compareCGPoints(a: CGPoint,b: CGPoint) ->  Bool {
    
    
    
    if distance(A: a, B: b) > 1 {
        return false
    }
    else if distance(A: a, B: b) < 1 {
        return true
    }
    else {
        return false
    }
    
}




