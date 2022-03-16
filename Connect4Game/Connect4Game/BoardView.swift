//
//  BoardVIew.swift
//  Connect4Game
//
//  Created by Dwayne Reinaldy on 3/10/22.
//

import UIKit

class BoardView: UIView {
    let boardToScreenRatio: CGFloat = 0.9
    
    var originX: CGFloat = 13
    var originY: CGFloat = 35
    var squareSide: CGFloat = 50
    
    var shadowPieces: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
    var shadowwinningPieces: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
    
    override func draw(_ rect: CGRect) {
        let boardWidth = bounds.width * boardToScreenRatio
        squareSide = boardWidth / CGFloat(ConnectFourGame.cols)
        originX = (1 - boardToScreenRatio) * bounds.width / 2
        originY = (bounds.height - CGFloat(ConnectFourGame.rows)*squareSide)/2
        
        drawBoard()
        drawPieces()
    }
    
    //tap location
    func columnAt(x : CGFloat) -> Int{
        return Int((x-originX) / squareSide)
    
    }
    
    //draw yellow and red pieces
    func drawPieces(){
        for i in shadowPieces{
            drawCircle(col: i.col, row: i.row, color: i.color ? .red : .yellow, withStroke: false)
        }
        for i in shadowwinningPieces{
            drawCircle(col: i.col, row: i.row, color: i.color ? .red : .yellow, withStroke: true)
        }
        
    }
    
    //draw the board
    func drawBoard(){
        UIColor.init(red: 0, green: 102/255, blue: 204/255, alpha: 1).setFill()
        let boardPath = UIBezierPath(roundedRect: CGRect(x: originX, y: originY, width: CGFloat(ConnectFourGame.cols)*squareSide, height:CGFloat(ConnectFourGame.rows)*squareSide ), cornerRadius: 0.25 * squareSide)
        boardPath.stroke()
        boardPath.fill()
        
        UIColor.white.setFill()
        for i in 0..<ConnectFourGame.rows{
            for j in 0..<ConnectFourGame.cols{
                drawCircle(col: j, row: i, color: .white, withStroke: false)
            }
            
        }
    }
    
    func drawCircle(col: Int , row: Int, color: UIColor, withStroke: Bool){
        color.setFill()
        let centerX: CGFloat = originX + 0.5 * squareSide + CGFloat(col) * squareSide
        let centerY: CGFloat = originY + 0.5 * squareSide + CGFloat(row) * squareSide
        let circle = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 0.4 * squareSide, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        circle.fill()
        if withStroke == true {
            UIColor.white.setStroke()
            circle.lineWidth = 3
            circle.stroke()
        }
    }

}
