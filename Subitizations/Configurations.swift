//
//  Subitize.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/12/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit



// Testing variable, used for analysis.
var FINALNODES: [CGPoint] = []

var r: CGFloat!

var centers: [CGPoint] = []

var Objects: [marble] = []

var ConfigurationNodes: [CGPoint] = []

class marble: UIImageView
{
    
    var mySpot = CGPoint(x: 0, y: 0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("IVE BEEN TOUCHED")
    }
    
    func panhandler(_ sender: UIPanGestureRecognizer)
    {
        
        
        if sender.state == .changed
        {
            let translation = sender.translation(in: self)
            
            self.frame.origin.x = translation.x + self.frame.origin.x
            self.frame.origin.y = translation.y + self.frame.origin.y
            
            sender.setTranslation(CGPoint.zero, in: self)
        }

 
    }
 

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        // Setting up the view.
        let pan = UIPanGestureRecognizer()
        self.addGestureRecognizer(pan)
        self.isUserInteractionEnabled = true
        pan.addTarget(self, action: #selector(self.panhandler(_:)))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    
}



    
func drawConfiguration(n: Int,marbles: [UIImageView],at: CGPoint,marblesize: CGFloat) {
    
    
        
        centers = buildnumber(n: n, r: marblesize/2)
    
        
        let figureOffset = getOffsetForConfiguration(points: centers,r: marblesize/2)

        let combinedOffset = addPoints(a: at, b: figureOffset)

        centers = centers.map({(element: CGPoint) -> CGPoint in return addPoints(a: element, b: combinedOffset)})
        
        
        for (index,center) in centers.enumerated() {
            
            if index < n
            {
           
            marbles[index].isHidden = false
            
            marbles[index].image = BallImages[Toggler%6]
            
            UIView.animate(withDuration: 0.5, animations: {marbles[index].center = center})
            }
            else {
                    
            marbles[index].isHidden = true
                
                
            }
            
        }
        
    
    
    

    
}





// Take a number and returns random array representing the a configuration of those points.
func randomConfiguration(n: Int) -> [CGPoint] {
    
    
    
    return [CGPoint(x: 0, y: 0)]
    
    
}






// Builds a random number
func buildnumber(n: Int,r: CGFloat) -> [CGPoint]
{
    
    // Node that the rest of the number will be built off of
    var centers = [CGPoint(x: 0, y: 0)]
    
    if n > 1 {
        
        for _ in 0...n-2 {
            
            var newNodes = getNodes(r: r, points: centers)
            
            print("These are the new nodes with duplicates:", newNodes," and there are ",newNodes.count)
            
            // Remove any nodes that are currently centers
            newNodes = newNodes.filter({!centers.contains($0)})
            
            print("Nodes")
            
            // Remove duplicate nodes
            var newNodesNoDuplicates = removeDuplicateNodes(nodes: newNodes)
            
            print("These are the new nodes without duplicates:",newNodesNoDuplicates,"and there are ",newNodesNoDuplicates.count)
            
            newNodesNoDuplicates = removeDuplicateNodes(nodes: newNodesNoDuplicates)
            
            print("This should REALLY not have any duplicates",newNodesNoDuplicates,"and there are ",newNodesNoDuplicates.count)
            
            
            
            let randomNode = newNodesNoDuplicates.randomItem()
            
            centers.append(randomNode)
            
            print("These are the current centers", centers)
            
        }}
    

    
    return centers
    
    
}




