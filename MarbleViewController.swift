//
//  ViewController.swift
//  Obsolecense Management Plan
//
//  Created by Andrew Fenner on 4/17/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

// UIElements

var vcMaAddBtn = UIButton()
var vcMaSubBtn = UIButton()

var Scattered = false
var Split = false

var Balls: [touchableBall] = []

// Initial balls in play set to 5
var BallsInPlay = 5

// Center of the view. Calculated on viewDidLoad
var vcMaCenter: CGPoint!

var vcMaBackBtn = UIButton()

var bouncedBallCenters: [CGPoint]!

// Pushes the ball centers outward so we can expand the shape. This is called each time the Balls aray is updated.
func bounceBallCenters() -> [CGPoint] {
    
    var returnNewPoints: [CGPoint] = []
    
    for (index,aBall) in Balls.enumerated() {
        
        let unitVector = subtractPoints(a: aBall.center, b: vcMaCenter)
        
        let vector = CGPoint(x: unitVector.x*1.10, y: unitVector.y*1.10)
        
        if index < BallsInPlay {
            
            let newCenter = addPoints(a: vcMaCenter, b: vector)
            
            returnNewPoints.append(newCenter)
            
        }
    }
    
    return returnNewPoints
    
}

func initOriginalCoordinates()
{
    
    for _ in 0...19
    {
        originalCoordinates.append(CGPoint(x: 0, y: 0))
    }
    
}





class MarbleViewController: UIViewController {
    
    var Help: helpview!
    
    
    
    
    @IBOutlet weak var HelpButton: UIButton!
    
    var colorPicker = colorpickermarbles()
    
    
    func back(sender: UIButton)
    {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
        
    }
    
    
    
    func addBall(sender: UIButton)
    {
        
      
        
        if BallsInPlay < 20
        {
            
            let newValue = BallsInPlay + 1
            
            
            if newValue > 10
            {
                b = newValue - 10
                a = 10
            }
            else if newValue <= 10
            {
                
                a = newValue
                b = 0
                
            }
            
            numbershape.composeNumber(a: newValue)
            
            Split = false
            
            Scattered = false
            
            BallsInPlay = BallsInPlay+1
            
        }
        
        bouncedBallCenters = bounceBallCenters()
        
        
    }
    
    func subBall(sender: UIButton)
    {
        
        if BallsInPlay > 0
        {
            
            let newValue = BallsInPlay - 1
            
            if newValue > 10
            {
                b = newValue - 10
                a = 10
            }
            else if newValue <= 10
            {
                
                a = newValue
                b = 0
                
            }
            
            numbershape.composeNumber(a: newValue)
            
            // When you add a ball they exit their state (either split or scattered)
            Split = false
            Scattered = false
            
            BallsInPlay = BallsInPlay - 1
            
        }
        
        bouncedBallCenters = bounceBallCenters()
        
        
        
    }
    
    
    
    
    // Create a numbershape view
    let numbershape = numbershapeview()
    
    
    func pinch(_ sender: UIPinchGestureRecognizer){
        
        
        if sender.scale > 1
        {
            
       
            UIView.animate(withDuration: 0.8, animations: {
                
            
                for (i,b) in Balls.enumerated() {
                
                
                    if i < BallsInPlay {
                        
                        b.center = bouncedBallCenters[i]
                        
                    }
                    
                }
            
            })
            
            Scattered = true
            
        }
        else{
            
            bouncedBallCenters = bounceBallCenters()
            
            if Scattered == true && Split == false
            {
                
                numbershape.animateto(coordinates: originalCoordinates)
                Scattered = false
                
            }
            else if Split == true
            {
                
                numbershape.composeNumber(a: BallsInPlay)
                Split = false
                
                if BallsInPlay > 10 {
                    
                    a = BallsInPlay - BallsInPlay%10
                    b = BallsInPlay%10
                }
                else if BallsInPlay <= 10
                {
                    a = BallsInPlay
                    b = 0
                    
                }
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleFillContainer(container: view.frame)
        
        // Create global variable for view center (purely for convenience)
        vcMaCenter = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        view.addSubview(numbershape)
        
        // Calculate the numbershapes frame:
        var numbershapesframe: CGRect {
            
            let w = view.frame.width*0.8
            let h = w/2
            let x = view.frame.width/2 - w/2
            let y = (view.frame.height/2 - h/2)*1.5
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        
        colorPicker.colorpickerStyle(frame: view.frame)
        colorPicker.drawButtons()
        
        view.addSubview(colorPicker)
        
        numbershape.frame = numbershapesframe
        
        numbershapeViewOrigin = numbershape.frame.origin
        
        vcMaAddBtn.addTarget(self, action: #selector(MarbleViewController.addBall(sender:)), for: .touchUpInside)
        vcMaSubBtn.addTarget(self, action: #selector(MarbleViewController.subBall(sender:)), for: .touchUpInside)
        
        
        vcMaAddBtn.StyleAddBtn(container: view.frame)
        vcMaSubBtn.StyleSubBtn(container: view.frame)
        
        view.addSubview(vcMaAddBtn)
        view.addSubview(vcMaSubBtn)
        
        BallDim = ballsize(frame: numbershapesframe.size).width
        
        r = BallDim/2
        
        let initBallFrame = CGRect(x: -BallDim, y: -BallDim, width: BallDim, height: BallDim)
        
        Balls = initBalls(number: 20, frame: initBallFrame)
        
        initOriginalCoordinates()
        
        for aBall in Balls
        {
            view.addSubview(aBall)
        }
        
        
        numbershape.composeNumber(a: BallsInPlay)
        
        centerOfScreen = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        
        NumberShapeFrame = numbershape.frame
        
        
        Help = helpview()
        
        view.addSubview(Help)
        
        
        
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(MarbleViewController.pinch(_:)))
        view.addGestureRecognizer(pinch)
        
        bouncedBallCenters = bounceBallCenters()
        
        view.addSubview(vcMaBackBtn)
        vcMaBackBtn.frame.styleBackBtn(view.frame)
        vcMaBackBtn.styleArrowBack()
        
        
        vcMaBackBtn.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        
        
        super.viewDidLoad()
        
        
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

