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

class RankTest:XCTestCase {
    func testResolveNamesBasedOnRank(){
        assert(HandRank(rank:1).name == RankName.StraightFlush)
        assert(HandRank(rank:10).name == RankName.StraightFlush)
        assert(HandRank(rank:11).name == RankName.FourOfAKind)
        assert(HandRank(rank:166).name == RankName.FourOfAKind)
        assert(HandRank(rank:167).name == RankName.FullHouse)
        assert(HandRank(rank:322).name == RankName.FullHouse)
        assert(HandRank(rank:323).name == RankName.Flush)
        assert(HandRank(rank:1599).name == RankName.Flush)
        assert(HandRank(rank:1600).name == RankName.Straight)
        assert(HandRank(rank:1609).name == RankName.Straight)
        assert(HandRank(rank:1610).name == RankName.ThreeOfAKind)
        assert(HandRank(rank:2467).name == RankName.ThreeOfAKind)
        assert(HandRank(rank:2468).name == RankName.TwoPairs)
        assert(HandRank(rank:3325).name == RankName.TwoPairs)
        assert(HandRank(rank:3326).name == RankName.OnePair)
        assert(HandRank(rank:6185).name == RankName.OnePair)
        assert(HandRank(rank:6186).name == RankName.HighCard)
        assert(HandRank(rank:7462).name == RankName.HighCard)
    }
}

class EvaluatorTest:XCTestCase {
    /**func testEvaluateStraightFlush() {
        assert(HandRank(rank:1) == Evaluator().evaluate(["T♣", "J♣", "Q♣", "K♣", "A♣"]))
        assert(HandRank(rank:10) == Evaluator().evaluate(["A♣", "2♣", "3♣", "4♣", "5♣"]))
    }**/
    
    func testEvaluateFourOfAKind() {
        assert(HandRank(rank:11) == Evaluator().evaluate(["K♣", "A♣", "A♥", "A♦", "A♣"]))
        assert(HandRank(rank:166) == Evaluator().evaluate(["3♣", "2♣", "2♥", "2♦", "2♣"]))
    }

    func testEvaluateFullHouse() {
        assert(HandRank(rank:167) == Evaluator().evaluate(["K♣", "K♥", "A♥", "A♦", "A♣"]))
        assert(HandRank(rank:322) == Evaluator().evaluate(["3♣", "3♥", "2♥", "2♦", "2♣"]))
    }

    /**func testEvaluateFlush() {
        assert(HandRank(rank:323) == Evaluator().evaluate(["9♣", "J♣", "Q♣", "K♣", "A♣"]))
        assert(HandRank(rank:1599) == Evaluator().evaluate(["2♣", "3♣", "4♣", "5♣", "7♣"]))
    }**/

    func testEvaluateStraight() {
        assert(HandRank(rank:1600) == Evaluator().evaluate(["T♣", "J♣", "Q♦", "K♥", "A♣"]))
        assert(HandRank(rank:1609) == Evaluator().evaluate(["A♣", "2♣", "3♦", "4♥", "5♣"]))
    }

    func testEvaluateThreeOfAKind() {
        assert(HandRank(rank:1610) == Evaluator().evaluate(["Q♣", "K♥", "A♥", "A♦", "A♣"]))
        assert(HandRank(rank:2467) == Evaluator().evaluate(["4♣", "3♥", "2♥", "2♦", "2♣"]))
    }

    func testEvaluateTwoPairs() {
        assert(HandRank(rank:2468) == Evaluator().evaluate(["Q♣", "K♣", "K♦", "A♥", "A♣"]))
        assert(HandRank(rank:3325) == Evaluator().evaluate(["4♣", "3♣", "3♦", "2♥", "2♣"]))
    }

    func testEvaluateOnePair() {
        assert(HandRank(rank:3326) == Evaluator().evaluate(["J♣", "Q♦", "K♦", "A♥", "A♣"]))
        assert(HandRank(rank:6185) == Evaluator().evaluate(["2♣", "2♦", "3♦", "4♥", "5♣"]))
    }

    func testEvaluateHighCard() {
        assert(HandRank(rank:6186) == Evaluator().evaluate(["9♣", "J♦", "Q♦", "K♥", "A♣"]))
        assert(HandRank(rank:7462) == Evaluator().evaluate(["2♣", "3♦", "4♦", "5♥", "7♣"]))
    }

}
