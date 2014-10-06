//
//  EvaluatorTest.swift
//  PokerHandEvaluator
//
//  Created by Ivan Sanchez on 06/10/2014.
//  Copyright (c) 2014 Gourame Limited. All rights reserved.
//

import Foundation
import XCTest

class DeckTest:XCTestCase {
    func testHas52Cards(){
        assert(Deck().count == 52, "Deck should have 52 cards")
    }
    func testRepresentCardAsBitPattern(){
        assert(0b1000000000000100101100100101 == Deck().as_binary("K♦"), "K♦ representation is incorrect")
        assert(0b10000001001100000111 == Deck().as_binary("5♠"), "5♠ representation is incorrect")
        assert(0b10000000001000100100011101 == Deck().as_binary("J♣"), "J♣ representation is incorrect")

    }
}
