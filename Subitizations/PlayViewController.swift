//
//  ViewController.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/12/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

// UI Elements

var StartButton: UIButton!

var NextButton: UIButton!

var TimerLabel: UILabel!

var ScoreLabel: UILabel!

var dT: CGFloat = 0

var RandomInt: Int { return Int(arc4random_uniform(7)) + 3 }

var Cycler = 0

class ViewController: UIViewController {

    var localTimer = Timer()
    
    var SubmissionTime: Double = 0
    
    var TestResponseButton: responsebutton!
    
    func startGame(sender: UIButton)
    {
        
        localTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        presentNewProblem()
    
        hide(view: sender)
        
    }
    
    func presentNewProblem()
    {
        
        // Hide
    
        CurrentCounter = BallImages[Cycler%6]
     
        print("Response Button Count",ResponseButtons.count)
        
        // This does not work
        
        for (index,button) in ResponseButtons.enumerated()
        {
            button.drawNumber(n: index+3)
        }
        
        Argument = RandomInt
        print("Argument",Argument)
        
        
        drawConfiguration(value: Argument, at: view.center, marbles: Marbles, ballimage: CurrentCounter, marblesize: 50)
     
        
        Cycler += 1
        

        
    }
    
    func updateTimer()
    {
        
        dT = dT + 0.01
        
        Countdown =  Countdown - 0.01
        
        TimeElapsed += 0.01
        
        TimerLabel.text = "\(Int(Countdown))"
        
    }
    

    
    func nextProblem(sender: UIButton)
    {
        
        
        
        // Set the time elapsed back to what it was when the answer was submitted.
        TimeElapsed = SubmissionTime

        hide(view: NextButton)
        
        ScoreLabel.text = "Total: \(Int(Score))"
        
        presentNewProblem()
        
    }
    
    
    func answerSubmit(sender: responsebutton) {
        
        // Record when the answer was submitted.
        SubmissionTime = TimeElapsed
        
        print("Time of Submission:",SubmissionTime)
        

        var score = 50/dT
        
        score = score*sqrt(CGFloat(sender._n))
        
        
        score = score/CGFloat((1 + abs(sender._n - Argument)))
        
        Score = Score + score
        
        
        // Present feedback
        
        ScoreLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        ScoreLabel.text = "\(Int(score)) Points!"
        
        UIView.animate(withDuration: 0.75, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)})
        
     
        // Present "Next" Button
        let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(presentNextButton)), userInfo: nil, repeats: false)
        
        
        // Show the true shape
        drawNumberShape(value: Argument, at: view.center,marbles: Marbles, ballimage: CurrentCounter, marblesize: 50)
        
        // Reset dT.
        dT = 0
        
 
        
    
        

     
        
    }
    
    
    func refreshMe(sender: UIButton)
    {
        
        TestResponseButton.drawNumber(n: 9)
        
    }
    
    
    func presentNextButton()
    {
        
        NextButton.center = CGPoint(x: view.frame.width/2, y: 1.2*view.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            NextButton.frame.styleCenterButton(container: self.view.frame) })
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
     
        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleFillContainer(container: view.frame)


        initMarbles(n: 10)
        

        // Add the marbles to the superview
        for marble in Marbles{
            
            marble.frame.size = CGSize(width: 50, height: 50)
            view.addSubview(marble)
            
        }
        
        initResponseButtons(container: DefaultFrame)
        
        let responseButtonFrames = getResponseButtonFrames(n: NumberOfButtons, container: view.frame)
        
        
        // Initialize all the response buttons.
        for (index,_) in ResponseButtons.enumerated()
        {
            
            
            if index < responseButtonFrames.count
            {
    
                print("Index when initializing start response buttons, is it ever zero?",index)
              
                // ResponseButtons[index].backgroundColor = UIColor.blue
                ResponseButtons[index]._n = index + 3
                ResponseButtons[index].frame = responseButtonFrames[index]
                ResponseButtons[index].drawNumber(n: index + 3)
                view.addSubview(ResponseButtons[index])
                ResponseButtons[index].addTarget(self, action: #selector(answerSubmit(sender:)), for: .touchUpInside)

                
                
                
            }
       
        }

     
        initStartButton(container: view.frame)
        initNextButton(container: view.frame)
        initTimerLabel(container: view.frame)
        initScoreLabel(container: view.frame)
        
      
        view.addSubview(NextButton)
        view.addSubview(TimerLabel)
        view.addSubview(StartButton)
        view.addSubview(ScoreLabel)
        
        StartButton.addTarget(self, action: #selector(startGame(sender:)), for: .touchUpInside)
        NextButton.addTarget(self, action: #selector(nextProblem(sender:)), for: .touchUpInside)
        
        
        
        
        
        /* TESTING CODE
        
        TestResponseButton = responsebutton(frame: DefaultFrame)
        view.addSubview(TestResponseButton)
        TestResponseButton.frame = CGRect(x: 50, y: 50, width: 150, height: 150)
        TestResponseButton.backgroundColor = UIColor.blue
        TestResponseButton.drawNumber(n: 7)
        
        TestResponseButton.addTarget(self, action: #selector(refreshMe(sender:)), for: .touchUpInside)
        
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

