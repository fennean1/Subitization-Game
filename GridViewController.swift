//
//  ViewController.swift
//  Obsolecense Management Plan
//
//  Created by Andrew Fenner on 4/17/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit



func initHundredGrid(size: CGFloat) -> [CGPoint] {
    
    var returnThisGrid: [CGPoint] = []
    
    for y in 0...9 {
        
        
        for x in 0...9
        {
            
            
            let newPointX = size*CGFloat(x)
            let newPointY = size*CGFloat(y)
            
            let newPoint = CGPoint(x: newPointX, y: newPointY)
            
            returnThisGrid.append(newPoint)
            
        }
        
    }
    
    
    return returnThisGrid
    
}





class GridViewController: UIViewController {
    
    
    var colorPicker = colorpicker()
    
    
    func drawElements(image: UIImage, at: [CGPoint],size: CGFloat)
    {
        
        var imageView: [griditem] = []
        
        for thispoint in at {
            
            
            let size = CGSize(width: size, height: size)
            
            let center = thispoint
            
            let initFrame = CGRect(origin: center, size: size)
            
            let newImage = griditem(frame: initFrame)
            
            newImage.center = center
            
            view.addSubview(newImage)
            
            imageView.append(newImage)
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        
        
        var gridPoints = initHundredGrid(size: 55)
        
        let meshCenter = getMeshCenter(mesh: gridPoints)
        
        let putMeshAt = CGPoint(x: view.frame.width/2, y: view.frame.height*0.6)
        
        let meshOffset = subtractPoints(a: putMeshAt, b: meshCenter)
        
        gridPoints = gridPoints.map({addPoints(a: $0, b: meshOffset)})
        
        drawElements(image: PinkBall, at: gridPoints, size: 55)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        colorPicker.colorpickerStyle(frame: view.frame)
        
        colorPicker.drawButtons()
        
        view.addSubview(colorPicker)
        
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

