# Programming-Languages-Course-Projects
* Programming Languages
  * COBOL
  * C
  * Java
  * Python
  * Perl
  * ML
  * Prolog
* Motivition: Programming languages embody many concepts central to all of computer science, including abstraction, generalization and automation, computability, and resource management. Studying programming languages enables one to examine these topics in a precisely defined, accessible domain, and the lessons learned from programming languages thus provide immediate insight into all aspects of our discipline.

* * * 

## [Project 1](project1)
* Implement TA ranking system once using __COBOL__ and once using __C__ 
* Input: 
  * Courses' requirements (instructors.txt)
  * Candidate TAs' skills and preferences (candidates.txt)
* Output:
  * Reports the top 3 TAs for each course, where TAs are ranked by matching scores (output.txt)
* Restriction
  * For __COBOL__ ,
    * ONLY 2 keywords are allowed in selection and loop statements: <code>IF</code> and <code>GOTO</code>
    * modern control constructs, such as if-then-else or while loop, are not allowed to use
  * Error Handling
  * Programming Style
    * Construct program with good readability and modularity. 
    * Provide sufficient documentation by commenting codes properly but never redundantly. 
    * Divide up programs into subroutines instead of clogging the main program. 
    * The main section only handle the basic file manipulation such as file opening and closing, and subprogram calling. 
       
  [Specification](Spec1.pdf)

* * * 

## [Project 2](project2)
* Implement and enhance board games once using __Python__ once using __Java__
* Main focuses are __Dynamic Typing__ and __Duck Typing__

### Task1: "Six Men's Morris"   
  * Game Board Representation
  * Place and moving the pieces (PUT, MOVE, REMOVE). A player forms a mill if three black pieces are lined up horizontally. A player wins by reducing the opponent to two pieces or by leaving them without a legal move.
  * Input: Player 1 and Player 2 to be either __human- or computer-controlled__
  * Classes and Functions
    * class SixMensMorris (board, players, num_play, next_player, opponent, check_win, start_game)
    * class Board (state, mills, edges, print_board, check_put, check_move, check_remove, put_piece, move_piece, remove_piece,form_mill, check_win)
    * class Player (id, symbol, board, next_put, next_move, next_remove)
    * class Human (next_put, next_move, next_remove)
    * class Computer (next_put, next_move, next_remove)
  * Usage
    * Python <code> python3 task1/SixMensMorris.py</code>

  * __ipython__ debug, i.e., simply insert “from IPython import embed; embed()” and run the program
* Task2: [Report](project2/report.pdf)
### Task3, 4: "Save The Tribe"  
* Duck Typing: _When I see a bird that walks like a duck and swims like a duck and quacks like a duck, I call that bird a duck._ In practical Python terms, this means that it is possible to try calling any method on any object, regardless of its class. An important advantage of Duck Typing is that we can enjoy polymorphism without inheritance. An immediate consequence is that we can write more generic codes, which are cleaner and more concise.
* Add new game element: merchant
         
  [Specification](Spec2.pdf)

* * * 


## [Project 3](project3)
* Implement a board game called "Golden Hook Fishing" in __Perl__
* Implement a simplified Monopoly game in Perl with __dynamic scoping__. 
* Re-implement the simplified Monopoly game using Python with __static scoping__.
* Version: Perl v5.18.2 and Python 3.4.0

### Task1: "Golden Hook Fishing"
* In each player’s turn, he/she takes a card from the top of the his/her deck and adds it to the tail of the desktop card stack. If there is another same-character card in the stack, the players can take the cards between these two cards (include these two cards) and put them at the bottom of his/her deck. A special situation is that if the player takes a “J” from the top of his/her deck, he/she can take all the cards on the desktop card stack to himself/herself. A player is out when the player has no cards in his/her deck. The game will end when only one player remains. The last remaining player is the winner.
* Classes and Functions
  * class Deck ( cards new, shuffle, AveDealCards)
  * class Player (name, cards; new, getCards, dealCards, numCards)
  * class Game ( deck, players, cards; new, setPlayers, getReturn, showCards, startGame)
 ### Task2: Monopoly
 * Dynamic Scoping
   * Implicitly affect the behaviour of functions by function calling sequences without passing extra parameters
   * Temporarily mask out some existing variables. Full marks on this task demands you to show both of these two properties with your code and explanations.
 * Both players start from the “Bank” with $100,000 and move clock-wisely. This game is turned- based, meaning the two players make moves alternately. Player A moves first. In each round, the players roll a six-sided dice in turn to decide how many steps to take. A Fixed cost of $200 will be charged per round, even if the player is in Jail. The player can pay an extra $500 to roll two dice and add up the numbers. When one of the players runs out of money, the game ends with the other player as the winner.
 * Classes and Functions
    * class Player (name, money, position, num_rounds_in_jail; new, move, payDue, putToJail, printAsset)
    * class Bank (new, print, stepOn)
    * class Jail (new, print, stepOn)
    * class Land (new, print, buyLand, upgradeLand, chargeToll, stepOn)   
         
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Specification](Spec3.pdf)

* * * 


## [Project 4](project4)
* Gain experience of declarative programming with __Prolog (Logic Programming)__ and __ML (Functional Programming)__ . Declarative programming is a programming paradigm that emphasises the expression of “what” the problem is over “how” to solve the problem.
* Version: SICStus 3.12.7; Standard ML of New Jersey, Version 110.0.7
### Task1: Logic Programming
* Implement Operations in list (element_last, element_n, remove_n, insert_n, repeat_three)
* Implement multi-way tree and functions (is_tree, num_node, sum_length)
* Usage:
    * Invoke Prolog <code>sics</code>
    * Load a file <code>?- [‘asg4.pl’]. </code> or <code>?- consult(‘asg4.pl’). </code> or <code>?- consult(‘asg4.pl’). </code>
### Task2: Functional Programming
* Implement several ML helper functions to determine the better hand in a card game simplified from Texas Hold’em. 
    * Hand: Four of a kind, Full House, Flush, Straight, Three of a Kind, Two Pairs, Pair, Nothing
    * ML functions: check_flush, compare_flush, check_straight, compare_straight, count_patterns
* Usage:
    * Download and install [SML/NJ](https://www.smlnj.org/)
    * Invoke SML <code>sml</code>
    * Load a file <code>use "asg4";</code>
    * Another way to direct execute the program <code>$sml < myfile</code>
             
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Specification](Spec4.pdf) 
     
    
