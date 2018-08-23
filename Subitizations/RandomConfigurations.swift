// For managing the creation and manipulatiion of random configuations of balls/marbles.


import Foundation
import UIKit


var r: CGFloat!

var centers: [CGPoint] = []

var ConfigurationNodes: [CGPoint] = []
class marble: UIImageView
{
    
    var mySpot = CGPoint()
    
    var x = "4"
    

    func panhandler(_ sender: UIPanGestureRecognizer)
    {
        
        let y = Int(x)
        
        if sender.state == .changed
        {
            let translation = sender.translation(in: self)
            
            self.frame.origin.x = translation.x + self.frame.origin.x
            self.frame.origin.y = translation.y + self.frame.origin.y
            
            sender.setTranslation(CGPoint.zero, in: self)
        }

 
    }
 

    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("Passing all touches to the next view (if any), in the view stack.")
        return false
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



    
func drawConfiguration(value: Int, at: CGPoint, marbles: [UIImageView], ballimage: UIImage, marblesize: CGFloat) {
    
        
        centers = buildnumber(n: value, r: marblesize/2)
    
        print("Count of centers before the number is drawn", centers.count)
    
        print("REMOVING DUPLICATES FROM CENTERS")
    
        print("Count of centers after removal",removeDuplicateNodes(nodes: centers).count)
    
        let figureOffset = getOffsetForConfiguration(points: centers,r: marblesize/2)

        let combinedOffset = addPoints(a: at, b: figureOffset)

        centers = centers.map({(element: CGPoint) -> CGPoint in return addPoints(a: element, b: combinedOffset)})
        
        
        for (index,_) in marbles.enumerated() {
            
            if index < value
            {
           
            marbles[index].isHidden = false
            
            marbles[index].image = ballimage
            
            UIView.animate(withDuration: 0.5, animations: {marbles[index].center = centers[index]})
            }
            else {
                    
           // marbles[index].isHidden = true
                
                hide(view: marbles[index])
                
                
            }
            
        }
    
}









// Builds a random number
func buildnumber(n: Int,r: CGFloat) -> [CGPoint]
{
    
    // Node that the rest of the number will be built off of
    var centers = [CGPoint(x: 0, y: 0)]
    
    if n > 1 {
        
        for _ in 0...n-2 {
            
            // Gets all available spots where a ball could be placed.
            var newNodes = getNodes(r: r, points: centers)
        
            
            // This is not working consistently to remove nodes that are already in the centers array.
            // newNodes = newNodes.filter({!centers.contains($0)})

            print("New Nodes Count",newNodes.count)
            for (i,nVal) in newNodes.enumerated()
            {
                for cVal in centers {
                    // Comparing CG points based on how far away they are instead of exact value.
                    if compareCGPoints(a: cVal, b: nVal) == true
                    {
                        let j = newNodes.index(of: nVal)!
                        print(j)
                        newNodes.remove(at: j)
                    }
                }
            }
            
            
            // Remove duplicate nodes
            let newNodesNoDuplicates = removeDuplicateNodes(nodes: newNodes)

            
            var randomNode = newNodesNoDuplicates.randomItem()
            print("This is the random node:",randomNode)
            print("These are the centers that should NOT contain the random node:",centers)
            
            print("IS THE node already in the centers?",centers.contains{$0 == randomNode})
        
            
            print("This is the centers before appending the new node",centers)
            
            // Add they new node to the random centers.
            centers.append(randomNode)
        
            print("FILTERING CENTERS AFTER APPENDING NEW NODE")
            let x = removeDuplicateNodes(nodes: centers)
            
       
            

       
        }}
    

    
    return centers
    
    
}

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}


