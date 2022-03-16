//
//  ViewController.swift
//  Connect4Game
//
//  Created by Dwayne Reinaldy on 3/10/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var whoseTurn: UILabel!
    @IBOutlet weak var playerOne: UILabel!
    @IBOutlet weak var playerOnePoint: UILabel!
    @IBOutlet weak var playerTwo: UILabel!
    @IBOutlet weak var playertwoPoint: UILabel!
    @IBOutlet weak var popUp: UIView!
    let droppingSound: AVAudioPlayer
    let gameoverSound: AVAudioPlayer
    
    @IBOutlet weak var popUpButton: UIView!
    @IBOutlet weak var playerWin: UILabel!
    @IBOutlet weak var nextgameButton: UIButton!
    required init?(coder: NSCoder) { // create initializer for drop sound effect
        let droppingsoundURL = Bundle.main.url(forResource: "drop_cropped", withExtension: "wav")!
        droppingSound = try! AVAudioPlayer(contentsOf: droppingsoundURL)
        droppingSound.prepareToPlay()
        
        let gameoverSoundURL = Bundle.main.url(forResource: "gameover", withExtension: "wav")!
        gameoverSound = try! AVAudioPlayer(contentsOf: gameoverSoundURL)
        gameoverSound.prepareToPlay()
        
        super.init(coder: coder)
    }
    
    
    var game: ConnectFourGame = ConnectFourGame()
    @IBOutlet weak var boardview: BoardView!
    override func viewDidLoad() { //first appearance of the game
        super.viewDidLoad()
        boardview.shadowPieces = game.pieces
        boardview.setNeedsDisplay()
        playerOne.textColor = .blue
        playerOnePoint.textColor = .blue
        nextgameButton.isHidden = true
        popUp.isHidden = true
    }
    
    func updateUI(){ // updating UI to reset or to show pieces in board
        if game.isYellowsTurn{
            playerTwo.textColor = .black
            playertwoPoint.textColor = .black
            whoseTurn.text = "Player 1's Turn"
            playerOne.textColor = .blue
            playerOnePoint.textColor = .blue
            
        }
        else{
            playerOne.textColor = .black
            playerOnePoint.textColor = .black
            whoseTurn.text = "Player 2's Turn"
            playerTwo.textColor = .blue
            playertwoPoint.textColor = .blue
        }
        boardview.shadowPieces = game.pieces
        boardview.setNeedsDisplay()
    }
    var p1Points: Int = 0
    var p2Points: Int = 0
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let fingerLocation = sender.location(in: boardview)
        let col = boardview.columnAt(x: fingerLocation.x)
        if game.dropAt(col: col){
            updateUI()
            if let winningPieces = game.gameOver(col: col){
                boardview.shadowwinningPieces = winningPieces
                boardview.setNeedsDisplay()
                playerTwo.textColor = .black
                playertwoPoint.textColor = .black
                playerOne.textColor = .black
                playerOnePoint.textColor = .black
                whoseTurn.text = game.isYellowsTurn ? "Player 2 wins" : "Player 1 wins"
                if game.isYellowsTurn {
                    nextgameButton.isHidden = false
                    p2Points+=1
                    playertwoPoint.text = "\(p2Points)"
                }
                else{
                    nextgameButton.isHidden = false
                    p1Points+=1
                    playerOnePoint.text = "\(p1Points)"
                }
                boardview.isUserInteractionEnabled = false
                gameoverSound.play()
            }
            else{
                droppingSound.play()
            }
        }
        boardview.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        if p1Points == 5 {
            popUp.isHidden = false
            playerWin.text = "Player 1 Wins"
            popUpButton.isHidden = false
            boardview.isUserInteractionEnabled = true
            blurView.translatesAutoresizingMaskIntoConstraints = false
            boardview.insertSubview(blurView, at: 0)
            
        }
        if p2Points == 5{
            popUp.isHidden = false
            playerWin.text = "Player 2 Wins"
            popUpButton.isHidden = false
            boardview.isUserInteractionEnabled = true
            blurView.translatesAutoresizingMaskIntoConstraints = false
            boardview.insertSubview(blurView, at: 0)
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        game.reset()
        boardview.shadowwinningPieces.removeAll()
        updateUI()
        boardview.isUserInteractionEnabled = true
        nextgameButton.isHidden = true
    }
    
    @IBAction func restartButton(_ sender: UITapGestureRecognizer) {
        game.reset()
        boardview.shadowwinningPieces.removeAll()
        updateUI()
        boardview.isUserInteractionEnabled = true
        nextgameButton.isHidden = true
        popUp.isHidden = true
        p1Points = 0
        p2Points = 0
        playerOnePoint.text = "\(p1Points)"
        playertwoPoint.text = "\(p2Points)"
    }
}

