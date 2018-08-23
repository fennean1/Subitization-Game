


// --- Library: Valuable components

import Foundation
import UIKit



// View that falls in from the upper left hand corner.
class modalview: UIView
{
    
    let label = UILabel()
    let scene = UIImageView()
    
    var contentview: CGRect
    {
        return self.bounds
    }
    
    var dropped = false
    
    var startframe: CGRect!
    
    
    // Hides the modal
    func putback()
    {
        if let start = startframe
        {
            
            self.layer.shadowPath = UIBezierPath(rect: RectZero).cgPath
            
            UIView.animate(withDuration: 1, animations:
                {self.frame = start})
        }
        
        dropped = false
        
    }
    
    // Drop function takes a message to display and then adds it to a view that animates by sliding into the view.
    func drop(_ image: UIImage,messege: String)
    {
        
        dropped = true
        
        let superrect = superview!.frame
        let HelpHeight = superrect.height*0.8
        
        
        
        label.font = UIFont(name: "ChalkBoard SE", size: HelpHeight/15)
        label.textAlignment = .center
        label.text = messege
        
        scene.image = image
    
        // Starts at CGRectZero before animation
        let endsize = CGSize(width: 3/4*HelpHeight, height: HelpHeight)
        
        startframe = CGRect(x: -superrect.width/2, y: -HelpHeight, width: 0, height: 0)
        
        var labelframe: CGRect {
            
            let x = CGFloat(0)
            let y = CGFloat(0)
            let h = HelpHeight/4
            let w = HelpHeight*3/4
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        var sceneframe: CGRect
        {
            let x = CGFloat(0)
            let y = 1/4*HelpHeight
            let h = HelpHeight*3/4
            let w = HelpHeight*3/4
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        scene.frame = sceneframe
        label.frame = labelframe
        
        self.frame = startframe
        

        
        UIView.animate(withDuration: 1, animations:
            {
                self.frame.size = endsize
                self.center = self.superview!.center
                // Could this be in init?
           
        },
        completion: {finished in self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath})
        

        
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        self.putback()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 10
        
      
        
      
        self.addSubview(scene)
        self.addSubview(label)
        
        // Setting up the view.
        let pan = UIPanGestureRecognizer()
        self.addGestureRecognizer(pan)
        pan.addTarget(self, action: #selector(self.panhandler(_:)))
        
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
    }
    
    
}



// get the coordinates for placing two numbers inside of the view
func decompose(a:Int, b: Int,frame: CGSize) -> [CGPoint]
{
    
    var p: [CGPoint] = []
    
    // Read the containers dimensions for convenience
    let containerwidth = frame.width
    let containerheight = frame.height
    
    // ballsize() in 'Helpers' - Calculates the size of a ball from a given frame.
    let ball = ballsize(frame: frame)
    
    

    // Set of points for number 'a'
    let ap = numbershapeXY(a: a, frame: ball)
    // Set of points for number 'b'
    let bp = numbershapeXY(a: b, frame: ball)
    
    
    
    let adim = getShapeCenterOffset(a: a, ballsize: ball.width,points: ap)
    let bdim = getShapeCenterOffset(a: b, ballsize: ball.height,points: bp)
    
    var aorigin = CGPoint(x: containerwidth/4, y: containerheight/2)
    aorigin.offset(point: adim)
    
    var borigin = CGPoint(x: 3*containerwidth/4, y: containerheight/2)
    borigin.offset(point: bdim)
    

    // Adjusted points for number 'a'
    let adjap = ap.flatMap({C in addPoints(a: C, b: aorigin)})
    

    
    // Adjusted points for number 'b'
    let adjbp = bp.flatMap({C in addPoints(a: C, b: borigin)})
    
    
    
    p = adjap + adjbp
    
    
    return p
    
}



// NEED TO WRITE THIS SO IT USES THE GET SHAPE SIZE METHOD INSTEAD!!!
func getShapeCenterOffset(a: Int, ballsize: CGFloat,points: [CGPoint]) -> CGPoint{
    

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
    
    
    return CGPoint(x: size.width/2, y: size.height/2)
    
}

// Offsets a particular point by another coordinate. Similar to adding function but only takes one argument for convenience.
extension CGPoint {
    
    
    mutating func offset(point: CGPoint) {
        
        let x = self.x - point.x
        let y = self.y - point.y
        
        self = CGPoint(x: x, y: y)
        
    }
    
}




// Color Picker






