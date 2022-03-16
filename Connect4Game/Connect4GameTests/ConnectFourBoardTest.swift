//
//  ConnectFourBoardTest.swift
//  Connect4GameTests
//
//  Created by Dwayne Reinaldy on 3/10/22.
//

import XCTest
@testable import Connect4Game

class ConnectFourBoardTest: XCTestCase {

    func testPrintBoard() {
        let game = ConnectFourGame()
        print(game)
    }

    func testPieceBoard(){
        var game = ConnectFourGame()
        game.pieces.insert(ConnectFourPiece(col: 0, row: 5, color: true))
        game.pieces.insert(ConnectFourPiece(col: 0, row: 4, color: false))

        print(game)
    }
}
