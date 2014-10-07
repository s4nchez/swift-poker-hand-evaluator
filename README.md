# swift-poker-hand-evaluator

A [Swift](https://developer.apple.com/library/prerelease/iOS/documentation/Swift/Conceptual/Swift_Programming_Language/index.html) library designed to evaluate poker hands.

## Usage

```swift

Evaluator().evaluate(["T♣", "J♣", "Q♣", "K♣", "A♣"])
// rank: 1, name: StraightFlush
```

## How it works

This implementation is currently based on [Kevin Suffecool's poker hand evaluator](http://www.suffecool.net/poker/evaluator.html)  (aka Cactus Kev's Poker Hand Evaluator).

A good reference to learn about this and other evaluators is [this blog post](http://www.codingthewheel.com/archives/poker-hand-evaluator-roundup/).