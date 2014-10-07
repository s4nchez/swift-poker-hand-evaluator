//
//  Evaluator.swift
//  PokerHandEvaluator
//
//  Created by Ivan Sanchez on 06/10/2014.
//  Copyright (c) 2014 Gourame Limited. All rights reserved.
//

import Foundation

public class Deck {
    var cards:[String:Int]
    var count: Int {
        get {
            return cards.count
        }
    }
    init(){
        /*
        Card representation as an integer, based on Kevin Suffecool's specs:
        
        +--------+--------+--------+--------+
        |xxxbbbbb|bbbbbbbb|cdhsrrrr|xxpppppp|
        +--------+--------+--------+--------+
        
        p = prime number of rank (deuce=2,trey=3,four=5,five=7,...,ace=41)
        r = rank of card (deuce=0,trey=1,four=2,five=3,...,ace=12)
        cdhs = suit of card
        b = bit turned on depending on rank of card
        */
        cards = [:]
        let suitDetails:[String: Int] = [
            "♠": 0b0001,
            "♥": 0b0010,
            "♦": 0b0100,
            "♣": 0b1000]
        let faces:[String:[String:Int]] = [
            "2":["index":0, "prime": 2],
            "3":["index":1, "prime": 3],
            "4":["index":2, "prime": 5],
            "5":["index":3, "prime": 7],
            "6":["index":4, "prime": 11],
            "7":["index":5, "prime": 13],
            "8":["index":6, "prime": 17],
            "9":["index":7, "prime": 19],
            "T":["index":8, "prime": 23],
            "J":["index":9, "prime": 29],
            "Q":["index":10, "prime": 31],
            "K":["index":11, "prime": 37],
            "A":["index":12, "prime": 41]]
        for face in faces.keys{
            for suit in suitDetails.keys {
                let faceIndex = faces[face]!["index"]!
                let faceValue = faceIndex << 8
                let suitValue = suitDetails[suit]! << 12
                let facePrime = faces[face]!["prime"]!
                let rank = 1 << (faceIndex + 16)
                cards[face+suit] = rank | suitValue | faceValue | facePrime
            }
        }
    }
    
    func as_binary(card:String) -> Int{
        return cards[card]!
    }
}

enum RankName{
    case HighCard
    case OnePair
    case TwoPairs
    case ThreeOfAKind
    case Straight
    case Flush
    case FullHouse
    case FourOfAKind
    case StraightFlush
}

private var rankStarts:[Int:RankName] = [
    7462: RankName.HighCard,
    6185: RankName.OnePair,
    3325: RankName.TwoPairs,
    2467: RankName.ThreeOfAKind,
    1609: RankName.Straight,
    1599: RankName.Flush,
    322: RankName.FullHouse,
    166: RankName.FourOfAKind,
    10: RankName.StraightFlush
]

class HandRank: Equatable {
    var rank:Int
    var name:RankName
    init(rank:Int) {
        self.rank = rank
        let start = rankStarts.keys.filter {$0 >= rank}.array.sorted { $0 < $1 }.first!
        self.name = rankStarts[start]!
    }
}

func == (lhs: HandRank, rhs: HandRank) -> Bool {
    return lhs.rank == rhs.rank
}

class Evaluator {
    var deck = Deck()
    
    func evaluate(cards:[String]) -> HandRank {
        let cardValues = cards.map {
            (var card) -> Int in
            return self.deck.as_binary(card)
        }
        let handIndex = cardValues.reduce(0,|) >> 16

        let isFlush:Bool = (cardValues.reduce(0xF000,&)) != 0

        if isFlush {
            let flushRank = flushes[handIndex]
            return HandRank(rank:flushRank)
        }

        let unique5Candidate = uniqueToRanks[handIndex]

        if (unique5Candidate != 0){
            return HandRank(rank:unique5Candidate)
        }

        let primes = cardValues.map {
            (var card) -> Int in
                return card & 0xFF
        }

        let primeProduct = primes.reduce(1, *)
        let combination = find(primeProductToCombination, primeProduct)!
        return HandRank(rank:combinationToRank[combination])
    }
}