//
//  ViewController.swift
//  Obsolecense Management Plan
//
//  Created by Andrew Fenner on 4/17/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

class MarbleViewController: UIViewController {
    
    var Help: helpview!
    
    
    
    
    @IBOutlet weak var HelpButton: UIButton!
    
    var colorPicker = colorpicker()
    
    
    
    
    
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
            
            
            
            Split = false
            
            Scattered = false
            
            BallsInPlay = BallsInPlay - 1
            
            
            
        }
        
        
    }
    
    
    
    
    // Create a numbershape view
    let numbershape = numbershapeview()
    
    
    func pinch(_ sender: UIPinchGestureRecognizer){
        
        if sender.scale > 1
        {
            
            let center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
            
            
            
            UIView.animate(withDuration: 0.8, animations: {
                
                for (index,aBall) in Balls.enumerated() {
                    
                    let unitVector = subtractPoints(a: aBall.center, b: center)
                    
                    let vector = CGPoint(x: unitVector.x*1.05, y: unitVector.y*1.05)
                    
                    if index < BallsInPlay {
                        
                        let newCenter = addPoints(a: center, b: vector)
                        
                        aBall.center = newCenter
                        
                    }
                }
                
                
            })
            
            Scattered = true
            
            
        }
        else{
            
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
        
        view.addSubview(numbershape)
        
        // Center the test view frame:
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
        
        addBtn.addTarget(self, action: #selector(MarbleViewController.addBall(sender:)), for: .touchUpInside)
        subBtn.addTarget(self, action: #selector(MarbleViewController.subBall(sender:)), for: .touchUpInside)
        
        
        
        addBtn.StyleAddBtn(container: view.frame)
        subBtn.StyleSubBtn(container: view.frame)
        
        view.addSubview(addBtn)
        view.addSubview(subBtn)
        
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

