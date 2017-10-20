# The Odin Project Assignment: ["Build Chess Game in Ruby"](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project)

My implementation of Chess - a two-player strategy board game played on a chessboard, a checkered gameboard with 64 squares arranged in an 8×8 grid. The game is played by millions of people worldwide. Please see [Wikipedia article](https://en.wikipedia.org/wiki/Chess) for extended info.

## Installation

Save Chess folder in your chosen location

And then inside of it execute:

    $ bundle    

## Usage

To play the game run:

    ruby Chess-game\lib\chess.rb
    
You can play as Bob (white pieces e.g. wP, wB, wQ) or Frank (black piesec e.g. bP, bB, bQ)

## To make your move use [Algebraic chess notation](https://en.wikipedia.org/wiki/Algebraic_notation_(chess))

To move a piece
    
    Nf3 (move a knight to f3)

    d3 (move a pawn to f3)

    Be5 (move a bishop to e5) 
    
You ought to omit indication that any capture has been made! Game will notice any captures automaticly.
    
If you move a piece to a position where another same piece can move, game will notice the it and ask you to be more specific. You can be more specific by inputing:

    e7-f6 (move a pawn from e7 to f6)

    Ng8-f6 (move a pawn from Ng8 to f6)
    
## Still in developement stage!! (TO DO!)

1. Simple Graphics
2. No Castling
3. No Draw
4. No AI available (sic!) :P
5. No clock or taken pieces table is working
6. No pawn promotion
7. More detail instructions in the game and in enghlish

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

\* See [license.txt](https://github.com/Kusnierewicz/Chess-game/blob/master/LICENSE.txt) for usage details.
