//
//  Connect4Game.swift
//  Connect4Game
//
//  Created by Dwayne Reinaldy on 3/10/22.
//

import Foundation

struct ConnectFourGame: CustomStringConvertible{
    
    static let cols: Int = 7
    static let rows: Int = 6
    
    var pieces: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
    var isYellowsTurn: Bool = true
    
    mutating func reset(){
        pieces.removeAll()
        isYellowsTurn = true
    }
    
    mutating func gameOver (col: Int) -> Set<ConnectFourPiece>? {
        let row = ConnectFourGame.rows - checkNumberofPieces(col: col)
        return fourConnectedat(col: col, row: row, color: isYellowsTurn)
    }
    
    func fourConnectedat(col : Int, row: Int, color: Bool) -> Set<ConnectFourPiece>?{
        var horizontal: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
        var vertical: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
        var diagonalTLtoBR: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
        var diagonalBLtoTR: Set<ConnectFourPiece> = Set<ConnectFourPiece>()
        
        for i in 1...3{
            if let piece  = pieceAt(col: col-i, row: row), piece.color == color {
                    horizontal.insert(piece)
            }
            if let piece = pieceAt(col: col-i, row: row + i), piece.color == color{
                    diagonalBLtoTR.insert(piece)
            }
            if let piece = pieceAt(col: col, row: row + i), piece.color == color{
                    vertical.insert(piece)
            }
            if let piece = pieceAt(col: col + i, row: row + i), piece.color == color{
                    diagonalTLtoBR.insert(piece)
            }
            if let piece = pieceAt(col: col + i, row: row), piece.color == color{
                    horizontal.insert(piece)
            }
            if let piece = pieceAt(col: col + i, row: row - i), piece.color == color{
                    diagonalBLtoTR.insert(piece)
            }
            if let piece = pieceAt(col: col, row: row - i), piece.color == color{
                    vertical.insert(piece)
            }
            if let piece = pieceAt(col: col - i, row: row - i), piece.color == color{
                    diagonalTLtoBR.insert(piece)
            }
            
            if horizontal.count == 3{
                horizontal.insert(pieceAt(col: col, row: row)!)
                return horizontal
            }
            else if vertical.count == 3{
                vertical.insert(pieceAt(col: col, row: row)!)
                return vertical
            }
            else if diagonalBLtoTR.count == 3{
                diagonalBLtoTR.insert(pieceAt(col: col, row: row)!)
                return diagonalBLtoTR
            }
            else if diagonalTLtoBR.count == 3{
                diagonalTLtoBR.insert(pieceAt(col: col, row: row)!)
                return diagonalTLtoBR
            }
        }
        return nil
    }
    //function to drop pieces
    mutating func dropAt(col: Int) -> Bool{
        if checkNumberofPieces(col:col)>=ConnectFourGame.rows{
            return false
        }
        let countPieces = checkNumberofPieces(col: col)
        let row = ConnectFourGame.rows - 1 - countPieces
        let newPiece = ConnectFourPiece(col: col, row: row, color: isYellowsTurn ? false : true )
        pieces.insert(newPiece)
        isYellowsTurn = !isYellowsTurn // change into other player's turn
        return true
    }
    
    // check how many pieces in a single column
    func checkNumberofPieces(col: Int)-> Int{
        var countPieces : Int = 0
        for i in pieces where i.col==col{
            countPieces += 1
        }
        return countPieces
    }
    
    func pieceAt(col: Int, row: Int) -> ConnectFourPiece?{
        for i in pieces{
            if col == i.col && row == i.row{
                return i
            }
        }
        return nil
    }
    var description: String{
        var desc = "  "
        for i in 0..<ConnectFourGame.cols{
            desc+="\(i) "
        }
        desc+="\n"
        for i in 0..<ConnectFourGame.rows{
            desc+="\(i) "
            for j in 0..<ConnectFourGame.cols{
                let piece = pieceAt(col: j, row: i)
                if piece == nil{
                    desc += ". "
                }
                else{
                    if piece!.color{
                        desc+="o "
                    }
                    else{
                        desc+="x "
                    }
                }
                
            }
            desc+="\n"
        }
        
        return desc
    }
}
