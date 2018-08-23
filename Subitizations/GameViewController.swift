//
//  ViewController.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/12/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

// --- UI Elements ---



// For whether or not a game has been started with vc Exits. Should be removed eventually.
// var vcGaDidInit = false

var ScoreLabel: UILabel!

var vcGaCounterImage = PinkBall

var vcGaMainMarble = BlueBall

var vcGaAccentMarble = OrangeBall

var MarbleSize: CGFloat = 0

var vcGaContainerSize: CGSize!

// The two marbles that will be used in a given turn. User can choose these at the beginning of the game and may change them between turns.
var MainMarble = BlueBall

var AccentMarble = OrangeBall

var GameOver = false

// Theoretically, there should be multiple levels. A level just stores the numbers that will be displayed in that level. That's why right now the "Current Level" is just 3 of each number. These numbers are presented randomely.

// Level used to shorten the game for testing:
var TestingLevel = [1,2,3,4,5,6,7,8,9,10]

// A modal that lets the player know when the game is over and displays performance data.
var Modal = modalview()

// Created with the notion that there would be multiple players. I'm sidelining that feature for the first release.
var CurrentPlayer: player!

var Attempts = CGFloat(0)

var currentTime: Double = 0
var timeOfTurnStart: Double = 0

var TimeElapsed: Double = 0

// The number being presented.
var Argument = 0

var timerRunning = false

// --- Styles ---

var firstTimeLoaded = true

func initScoreLabel(container: CGRect)
{
    
    ScoreLabel = UILabel()
    
    ScoreLabel.frame.styleScoreLabel(container: container)
    let scoreLabelFontSize = ScoreLabel.frame.height*0.7
    ScoreLabel.font = UIFont(name: "ChalkBoard SE", size: scoreLabelFontSize)
    ScoreLabel.textAlignment = .center
    
}


var vcGaStartButton = UIButton()

var vcGaNextButton = UIButton()

var vcGaBackBtn = UIButton()


class GameViewController: UIViewController {
    
    var CurrentLevel = LevelOne
    
    var turnTimer = Timer()
    
    // This variable should only last for the lifetime of the player.
    var Score: CGFloat = 0

    
    @IBOutlet weak var timeTracker: UILabel!
    
    
    var localTimer = Timer()

    var inGameTrophyView = UIImageView()
    
    // Array of marbles that get displayed during the game
    var Marbles: [marble] = []
    
    var ResponseButtons: [responsebutton] = []

    var vcGaTrophyButtons: [trophybutton] = []

    @IBOutlet weak var timerView: UILabel!
    
    // When accented marbles are updated, update the tropy buttons. This is not yet implemented. This variable needs to be updated when a ball is touched.
    var vcGaAccentedMarbles: Int = 0 {
        
        didSet(newValue) {
            
            for (_,b) in ResponseButtons.enumerated()
            {
                // Must only be called if the index equals the number of marbles that have been accented.
                ResponseButtons[newValue].drawNumber(n: newValue, image: vcGaAccentMarble)
                
            }
        }
        
        
    }

    // Initialization
    func initTrophyButtons(container: CGRect) {
        
        
        for index in 0...9
        {
            
            let newButton = trophybutton()
            
            newButton.level = index
            
            vcGaTrophyButtons.append(newButton)
            
        }
        
        
    }
    
    func initResponseButtons(container: CGRect) {
        
        // This gets the frames that the response buttons will occupy. They are calculated based on the number of buttons and the frame that they are to be drawn in.
        let responseButtonFrames = getResponseButtonFrames(n: 10, container: view.frame)
        
        // Create the response buttons array.
        for _ in 1...10
        {

            let newButton = responsebutton(frame: container)
            
            ResponseButtons.append(newButton)
            
        }
        
        // Draw all the response buttons.
        for (index,_) in ResponseButtons.enumerated()
        {
            
            if index < responseButtonFrames.count
            {
                // ResponseButtons[index].backgroundColor = UIColor.blue
                
                ResponseButtons[index]._n = index // So that the response button knows what value it corresponds to.
                ResponseButtons[index].frame = responseButtonFrames[index]
                ResponseButtons[index].drawNumber(n: index+1, image: vcGaMainMarble)
                view.addSubview(ResponseButtons[index])
                ResponseButtons[index].addTarget(self, action: #selector(answerSubmit(sender:)), for: .touchUpInside)
                
            }
            
        }
        
    }

    
    func startGame(sender: UIButton)
    {
        
        print("Start Game Pressed")
        
        currentTime = 0
        timeOfTurnStart = 0
        
        
        
        print("This is the current level:",CurrentLevel)
        

        initResponseButtons(container: view.frame)
        
        // Create new player
        CurrentPlayer = player()
        CurrentPlayer.playing = true
        CurrentPlayer.initPerformanceDataContext() // Just an array that stores data about the players game.
        print("The new player's performance data context has been set to:",CurrentPlayer.myPerformanceData)
        Attempts = 0
        
     
        // Present new problems returns a value based on whether it has succeeded or not.
        _ = presentNewProblem()
    
        
        // Hide the start button
        hide(view: sender)
        
    }
    
    // Called when game has ended or player exits the viewController
    func resetGame()
    {
        
        GameOver = false
        
        Score = 0
        
        Attempts = 0
        
        currentTime = 0
        timeOfTurnStart = 0
        
        // Clear the trophy images
        for t in vcGaTrophyButtons
        {
            t.setImage(nil, for: .normal)
        }
        
        inGameTrophyView.image = nil
        
        
        // I'm hiding the response buttons on reset so the reanimate upon restart.
        for button in ResponseButtons
        {
            button.removeFromSuperview()
        }
        
        for m in Marbles
        {
            m.frame.styleHideTopLeft(hide: m.frame)
        }
        
        // Array will get recreated when we call initResponseButtons
        ResponseButtons = []
    
        hide(view: vcGaNextButton)
        
        Argument = 0
        
        TestingLevel = [1,2,3,4,5,6,7,8,9,10]
        
        // Numbers get plucked away from the level during the game, that's why they must be replaced upon exit.
        CurrentLevel = LevelOne
        
        // "Playing" is only set to true during an active turn.

        
    }
    
    func goBack(sender: UIButton) {
        
        print("Go Back Pressed")
        
        view.addSubview(vcGaStartButton)
        view.addSubview(ScoreLabel)
        view.addSubview(vcGaBackBtn)
        view.addSubview(Modal)
    
        localTimer.invalidate()
        
        resetGame()
        
        print("Current Level:",CurrentLevel)
    
        print("Going back to WelcomeViewController")
        
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
    }
    
    func presentNewProblem() -> Bool
    {
        
        // Returns zero if there are no more questions.
        Argument = pluckProblemFromCurrentLevel()
        print("This is the problem that was plucked:",Argument)

        // Present new problem exits and returns false if there are no more problems in the the level. NOTE: There may be a better way to detect the end of the game cycle.
        guard Argument != 0 else
        {
            
            print("The current level should be empty. CurrentLevel = ",CurrentLevel)
            
            return false
        }

     
        print("Player is currently solving a problem...")
        CurrentPlayer.playing = true
    
        drawConfiguration(value: Argument, at: view.center, marbles: Marbles, ballimage: MainMarble, marblesize: MarbleSize)
        
  
        return true
        
    }
    
    func fadeTimer(){
    
        fadeMarbles(timing: 1)
    }
    
    
    
    func updateTimer()
    {
        currentTime += 0.01
      
    }
    
    func resetTimer(){
        turnTimer.invalidate()
        
        // Creates a timer that does not repeat Present "Next" Button
        turnTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: (#selector(fadeTimer)), userInfo: nil, repeats: false)
        
    }
    
    func nextProblem(sender: UIButton)
    {
        

        revealMarbles()
        

        resetTimer()
        
        
        // Check to see if presentNewProblem() returns true. This actually calls presentNewProblem. (Does it?)
        guard presentNewProblem() == true else {
            
            
            // Once we have entered this, the game is over.
            print("The game is over because presentNewProblem returned false")
            
            let earnedTrophy = getTrophy(percentage: Score/10/Normalizer)!
            
            // Need to re - write modal so it can handle next user action. 
            Modal.drop(earnedTrophy, messege: "\(Score)")
            
            vcGaStartButton.frame.styleCenterButton(container: self.view.frame)
            
            // Hide the marbles on the view
            for m in Marbles
            {
                m.frame.styleHideTopLeft(hide: m.frame)
            }
            
            resetGame()
            
            return
            
        }
        
        
        
        // Still counting time based on previous answer timestamp
        timeOfTurnStart = currentTime
        
        
        CurrentPlayer.playing = true
        
        hide(view: inGameTrophyView)
        
        UIView.animate(withDuration: 0.5, animations: {
            vcGaNextButton.frame.styleHideNextButton(container: self.view.frame)}, completion: {finished in })
    
        ScoreLabel.text = "Total: \(Int(Score))"
        
    }
    
    
    func answerSubmit(sender: responsebutton) {
        
        revealMarbles()
        
        turnTimer.invalidate()
        
        // If the player isn't playing then nothing should happen when these buttons are pressed. We used the Bool "Playing" state so we don't have to disable each button everytime we don't want them to respond.
        guard CurrentPlayer.playing == true else {
            
            print("Shouldn't be able to press me!")
            
            return
            
        }
        
        print(CurrentLevel,"< - This is what's in the current level")
        
        // Prepaare score label to animate by giving it a "zeroed out" frame.
        ScoreLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        inGameTrophyView.frame = CGRect(x: vcGaContainerSize.width/2, y: vcGaContainerSize.height/5, width: 0, height: 0)
        print("The score label frame has been set to RectZero prior to animation")
  
        
        // Just receives the centers from the existing marbles.
        let originalCenters = Marbles.map({$0.center})
        
        
       // Pushes an array of points outward from their collective center. Takes the center of their containing view and pushes outward by a scale factor to make them "spread apart"
        
       let bouncedCenters = bouncePoints(points: originalCenters, center: self.view.center)
        
        // sender._n? why did I name that _n?
        if sender._n == Argument {
            
            let dT = CGFloat(currentTime - timeOfTurnStart)
            
            CurrentPlayer.playing = false
            print("The current player is no longer in the Playing state and must press Next to go to the next turn")

            print("It took you:",dT,"seconds")
            let newScore = calculateScore(dT: dT,number: Argument,penalty: Attempts)
            print("The new score has been calculated:",newScore,"Points")
            
            Attempts = 0
            print("The correct answer has been received and the number of attempts have been set back to:",Attempts)
            

            Score = Score + CGFloat(newScore)
            
            // Present feedback
            ScoreLabel.text = "\(Int(newScore)) Points!"
            
            CurrentPlayer.updatePerfomanceDataFor(n: Argument, with: CGFloat(newScore))
            
            // We've stopped updating trophies mid-game.
            // vcGaTrophyButtons[Argument-1].updateTrophy(percentage: CurrentPlayer.myPerformanceData[Argument-1].1/Normalizer)
            
            // UIView.animate(withDuration: 0.4, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in })
            
            
            
            inGameTrophyView.image = getTrophy(percentage: CGFloat(newScore)/Normalizer)
            
                UIView.animate(withDuration: 0.4, animations: {self.inGameTrophyView.frame.styleInGameTrophyView(container: self.view.frame)},completion: {finished in })
            
          
            
            // Creates a timer that does not repeat Present "Next" Button
            let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(presentNextButton)), userInfo: nil, repeats: false)
            
            
            // Show the true shape
            drawNumberShape(value: Argument, at: view.center,marbles: Marbles, ballimage: vcGaMainMarble, marblesize: MarbleSize)
            
            
        }
        else {

            let dN = abs(sender._n - Argument)

            let errorSeverity = CGFloat(CGFloat(dN)/CGFloat(sender._n))
    
            Attempts += 2*errorSeverity
            print("A new attempt has been recorded and the total count is now:",Attempts)
            
            
            UIView.animate(withDuration: 0.3, animations: {
                
                for (j,m) in self.Marbles.enumerated()
                {
                    
                    m.center = bouncedCenters[j]
                
                }
                
            },
            completion: {finished in

             
            UIView.animate(withDuration: 0.3, animations: {
                    
                    print("Animating to original centers",originalCenters)
                    
                    
                    for (i,m) in self.Marbles.enumerated()
                    {
                        m.center = originalCenters[i]
                    }
                    
                })
 
            })

            
            resetTimer()
 
            ScoreLabel.text = "Try Again"
            
            
            // Do I need this?
            UIView.animate(withDuration: 0.8, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in
            })
            
        }
     
        print("The players performance data is",CurrentPlayer.myPerformanceData)
 
    }
    
    func fadeMarbles(timing: Double) {
        UIView.animate(withDuration: timing, animations: {
            
            for m in self.Marbles {
                m.alpha = 0
            }
            
        })
    }
    
    func revealMarbles() {
            for m in self.Marbles {
                m.alpha = 1
            }
    }
    
    
    func presentNextButton()
    {
        
        // Really shouldn't be handling this case here.
        if CurrentPlayer.playing == false
        {
        
        vcGaNextButton.center = CGPoint(x: view.frame.width*1.3, y: view.frame.height/2)
        

        UIView.animate(withDuration: 0.5, animations: {
            vcGaNextButton.frame.styleNextButton(container: self.view.frame)}, completion: {finished in
            
        
            }
            
            
            
            )
            
  
            
        }
 
        
    }
    
    
    // Removes and returns a random element from the array.
    func pluckProblemFromCurrentLevel() -> Int {
        
        
        print("Count of current level:",CurrentLevel.count)
    
        guard CurrentLevel.count > 0 else {
            
            print("No more problems in this level")
            
            return 0
            
        }
        
        
        let rand = Int(arc4random_uniform(UInt32(CurrentLevel.count)))
        print("Random Index from count",rand)
        
        let returnThis = CurrentLevel[rand]
        
        CurrentLevel.remove(at: rand)
        print("Something Was Removed!!!!")
        
        return returnThis
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // Initializes the marble array (currently always n = 10...but you never know.)
    func initMarbles(n: Int) {
        
        for _ in 1...n
        {
            
            let newMarble = marble(frame: DefaultFrame)
            
            newMarble.frame.size = CGSize(width: BallSize, height: BallSize)
            
            Marbles.append(newMarble)
            
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        
        CurrentLevel = LevelOne
        
        Score = 0
        
        Attempts = 0

        vcGaContainerSize = view.frame.size
        
        MarbleSize = view.frame.height/15

        
        localTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
  
  
        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleFillContainer(container: view.frame)
        
        
        // Initializes the array of marbles
        initMarbles(n: 10)
        
        ResponseButtons = []
        
        if firstTimeLoaded {
            initResponseButtons(container: DefaultFrame)
     
            firstTimeLoaded = false
        }
        
        vcGaStartButton.addTarget(self, action: #selector(startGame(sender:)), for: .touchUpInside)
        vcGaNextButton.addTarget(self, action: #selector(nextProblem(sender:)), for: .touchUpInside)
        vcGaBackBtn.addTarget(self, action: #selector(goBack(sender:)), for: .touchUpInside)
        
        
        initResponseButtons(container: DefaultFrame)
        
        initTrophyButtons(container: DefaultFrame)
        
        
        // Add the marbles to the superview
        for marble in Marbles{
            
            marble.frame.size = CGSize(width: MarbleSize, height: MarbleSize)
            view.addSubview(marble)
            
        }
      
        
        // Add the inGameGrophy View
        view.addSubview(inGameTrophyView)
        inGameTrophyView.frame.styleInGameTrophyView(container: view.frame)
  
        let trophyButtonFrames = getTrophyButtonFrames(n: NumberOfTrophies, container: view.frame)

        // Initialize all the trophy buttons
        for (index,_) in vcGaTrophyButtons.enumerated()
        {
            
            if index < trophyButtonFrames.count
            {
    
                vcGaTrophyButtons[index].frame = trophyButtonFrames[index]
                view.addSubview(vcGaTrophyButtons[index])
                
            }
            
        }


        
        initScoreLabel(container: view.frame)
        
        // Style Frames
        vcGaStartButton.frame.styleCenterButton(container: view.frame)
        vcGaBackBtn.frame.styleBackBtn(view.frame)
      
        
        // Add to superview
        view.addSubview(vcGaNextButton)
        view.addSubview(vcGaStartButton)
        view.addSubview(ScoreLabel)
        view.addSubview(vcGaBackBtn)
        view.addSubview(Modal)

        
        // Style Objects
        vcGaBackBtn.styleArrowBack()
        vcGaNextButton.setImage(nextBtn, for: .normal)
        vcGaStartButton.styleChalkRect(text: "Start")
        
        
 
        
        print("Time of Turn Start",timeOfTurnStart)
        
        // view.bringSubview(toFront: timeTracker)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

