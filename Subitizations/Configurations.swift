// For managing the creation and manipulatiion of random configuations of balls/marbles.


import Foundation
import UIKit



// Testing variable, used for analysis.
var FINALNODES: [CGPoint] = []

var r: CGFloat!

var centers: [CGPoint] = []

var ConfigurationNodes: [CGPoint] = []

class marble: UIImageView
{
    
    var mySpot = CGPoint(x: 0, y: 0)
    
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
    
        
        let figureOffset = getOffsetForConfiguration(points: centers,r: marblesize/2)

        let combinedOffset = addPoints(a: at, b: figureOffset)

        centers = centers.map({(element: CGPoint) -> CGPoint in return addPoints(a: element, b: combinedOffset)})
        
        
        for (index,_) in marbles.enumerated() {
            
            if index < value
            {
           
            marbles[index].isHidden = false
            
            marbles[index].image = CurrentCounter
            
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
            
            
            var newNodes = getNodes(r: r, points: centers)
      
            
            // Remove any nodes that are currently centers
            newNodes = newNodes.filter({!centers.contains($0)})
            
        
            
            // Remove duplicate nodes
            var newNodesNoDuplicates = removeDuplicateNodes(nodes: newNodes)
            

            newNodesNoDuplicates = removeDuplicateNodes(nodes: newNodesNoDuplicates)
    
            
            
            let randomNode = newNodesNoDuplicates.randomItem()
            
            centers.append(randomNode)
       
            
        }}
    

    
    return centers
    
    
}




