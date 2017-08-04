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

var Cycler = 0

var GameOver = false

var CurrentLevel = Levels[0]

var Modal = modalview()

var CurrentPlayer: player!

var Attempts = 0

class ViewController: UIViewController {

    var localTimer = Timer()
    
    var SubmissionTime: Double = 0
    
    func startGame(sender: UIButton)
    {
        for trophy in TrophyButtons
        {
            trophy.setImage(nil, for: .normal)
        }
        
        
        // Create new player
        CurrentPlayer = player()
        CurrentPlayer.myCurrentLevel = Levels[0]
        CurrentPlayer.Playing = true
        CurrentPlayer.initPerformanceDataContext()
        Attempts = 0
        
        
        localTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        _ = presentNewProblem()
    
        // Hide the start button
        hide(view: sender)
        
    }
    
    func presentNewProblem() -> Bool
    {
        
        // Hide
    
        // Returns zero if the current level is out of questions.
        Argument = pluckProblemFromCurrentLevel()
        
        print("Number of Problems Left",CurrentLevel.problemSet.count)
        
        guard Argument != 0 else
        {
            return false
        }

     
        CurrentCounter = BallImages[Cycler%6]
     

        CurrentPlayer.Playing = true
        dT = 0
        
     
        for (index,button) in ResponseButtons.enumerated()
        {
            button.drawNumber(n: index + 1)
        }
        
   
        drawConfiguration(value: Argument, at: view.center, marbles: Marbles, ballimage: CurrentCounter, marblesize: 50)
     
        
        Cycler += 1

        
        return true
        
    }
    
    func updateTimer()
    {
        
        if CurrentPlayer.Playing == true
        {
            dT = dT + 0.01
        }
        
        
    }
    

    
    func nextProblem(sender: UIButton)
    {
        
        
        // Set the time elapsed back to what it was when the answer was submitted.
        guard presentNewProblem() == true else {
            
            // ENDING GAME
            CurrentPlayer.Playing = false
            
            
            // Reset The level
            CurrentLevel = Levels[0]
            
            CurrentPlayer.initPerformanceDataContext()
            print("Current Performance",CurrentPlayer.myPerformanceData)
         
            
            let earnedTrophy = trophy(percentage: Score/Normalizer)!
            
            Score = 0
            dT = 0
            
            Modal.drop(earnedTrophy, messege: "Level \(CurrentPlayer.myCurrentLevel.index+1) Complete!")
            
            StartButton.frame.styleCenterButton(container: self.view.frame)
            
            return
            
        }
        
        CurrentPlayer.Playing = true
        
        hide(view: NextButton)
        
        ScoreLabel.text = "Total: \(Int(Score))"
        
    }
    
    
    func answerSubmit(sender: responsebutton) {
        
        
        guard CurrentPlayer.Playing == true else {
            
            
            print("Shouldn't be able to press me!")
            
            return
            
        }
        
        Attempts += 1
        
  
        // TimerLabel.text = "\(Int(60 - SubmissionTime))"

        ScoreLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
     
        
  
        let originalCenters = Marbles.map({$0.center})
        
       let bouncedCenters = bouncePoints(points: originalCenters, center: self.view.center)
        
        
        if sender._n == Argument {
            
            Attempts = 0
            
            CurrentPlayer.Playing = false
            
            let score = calculateScore(dT: dT,number: Argument,attempts: Attempts)

            Score = Score + CGFloat(score)
            
            // Present feedback
            
            ScoreLabel.text = "\(Int(score)) Points!"
            
            print("The current level is",CurrentLevel.index)
            
            CurrentPlayer.updatePerfomanceDataFor(n: Argument, with: CGFloat(score))
            
            TrophyButtons[Argument-1].updateTrophy(percentage: CurrentPlayer.myPerformanceData[Argument-1].1/Normalizer)
            
            UIView.animate(withDuration: 0.4, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in
                
            })
            
            
            // Present "Next" Button
            let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(presentNextButton)), userInfo: nil, repeats: false)
            
            
            // Show the true shape
            drawNumberShape(value: Argument, at: view.center,marbles: Marbles, ballimage: CurrentCounter, marblesize: 50)
            
            
            
        }
        else {
            


            
            UIView.animate(withDuration: 0.3, animations: {
                
                for (j,m) in Marbles.enumerated()
                {
                    
                    m.center = bouncedCenters[j]
                    
                    
                    
                }
                
            },
            completion: {finished in
                

             
            UIView.animate(withDuration: 0.3, animations: {
                    
                    print("Animating to original centers",originalCenters)
                    
                    
                    for (i,m) in Marbles.enumerated()
                    {
                        m.center = originalCenters[i]
                    }
                    
                })
 

 
            })

 
            ScoreLabel.text = "Try Again"
            
            UIView.animate(withDuration: 0.8, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in
            })
            
        }
     
        
 
    }
    
    func pickLevel(sender: trophybutton) {
        
        
        
       /* print("Picking level",sender.level)
        
        CurrentLevel = Levels[sender.level]
        
        GameOver = false
        
        UIView.animate(withDuration: 0.5, animations: {StartButton.frame.styleCenterButton(container: self.view.frame)})
      */
        
        
    }
    
    
    func presentNextButton()
    {
        
        if CurrentPlayer.Playing == false
        {
        
        NextButton.center = CGPoint(x: view.frame.width/2, y: 1.2*view.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            NextButton.frame.styleCenterButton(container: self.view.frame) })
        }
 
        
    }
    
    
    // Removes and returns a random element from the array.
    func pluckProblemFromCurrentLevel() -> Int {
        
    
        guard CurrentPlayer.myCurrentLevel.problemSet.count > 0 else {
            
            print("No more problems in this level")
            
            return 0
            
        }
        
        let rand = Int(arc4random_uniform(UInt32(CurrentPlayer.myCurrentLevel.problemSet.count)))
        
        let returnThis = CurrentPlayer.myCurrentLevel.problemSet[rand]
        
        CurrentPlayer.myCurrentLevel.problemSet.remove(at: rand)
        
        return returnThis
        
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
        initTrophyButtons(container: DefaultFrame)
        
        let responseButtonFrames = getResponseButtonFrames(n: NumberOfButtons, container: view.frame)
        let trophyButtonFrames = getTrophyButtonFrames(n: NumberOfTrophies, container: view.frame)
        
        // Initialize all the response buttons.
        for (index,_) in TrophyButtons.enumerated()
        {
            
            
            if index < trophyButtonFrames.count
            {
                
                
                TrophyButtons[index].frame = trophyButtonFrames[index]
                view.addSubview(TrophyButtons[index])
                // TrophyButtons[index].setImage(EmptyTrophy, for: .normal)
                TrophyButtons[index].addTarget(self, action: #selector(pickLevel(sender:)), for: .touchUpInside)
                
                
            }
            
        }
        
        // Initialize all the response buttons.
        for (index,_) in ResponseButtons.enumerated()
        {
            
            
            if index < responseButtonFrames.count
            {
    
            
                // ResponseButtons[index].backgroundColor = UIColor.blue
                ResponseButtons[index]._n = index
                ResponseButtons[index].frame = responseButtonFrames[index]
                view.addSubview(ResponseButtons[index])
                ResponseButtons[index].addTarget(self, action: #selector(answerSubmit(sender:)), for: .touchUpInside)
                
                
            }
       
        }

        
        
        Levels = initLevels()
        
        
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
        
        
        view.addSubview(Modal)
           

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

