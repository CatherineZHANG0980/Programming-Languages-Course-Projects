# * CSCI3180 Principles of Programming Languages
# *
# ∗ --- Declaration --- ∗
# ∗ I declare that the assignment here submitted is original except for source
# ∗ material explicitly acknowledged. I also acknowledge that I am aware of
# ∗ University policy and regulations on honesty in academic work, and of the
# ∗ disciplinary guidelines and procedures applicable to breaches of such policy
# ∗ and regulations, as contained in the website
# ∗ http://www.cuhk.edu.hk/policy/academichonesty
# ∗ Assignment 3
# ∗ Name : Zhang Xin Yu
# ∗ Student ID : 1155091989
# ∗ Email Addr : xyzhang7@cse.cuhk.edu.hk 

#! /usr/bin/perl
use warnings;
use strict;
require "./Bank.pm";
require "./Jail.pm";
require "./Land.pm";
require "./Player.pm";

our @game_board = (
    new Bank(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
    new Jail(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
);
our $game_board_size = @game_board;

our @players = (new Player("A"), new Player("B"));
our $num_players = @players;

our $cur_player_idx = 0;
our $cur_player = $players[$cur_player_idx];
our $cur_round = 0;
our $num_dices = 1;

srand(0); # don't touch

# game board printing utility. Used to show player position.
sub printCellPrefix {
    my $position = shift;
    my @occupying = ();
    foreach my $player (@players) {
        if ($player->{position} == $position && $player->{money} > 0) {
            push(@occupying, ($player->{name}));
        }
    }
    print(" " x ($num_players - scalar @occupying), @occupying);
    if (scalar @occupying) {
        print("|");
    } else {
        print(" ");
    }
}

sub printGameBoard {
    print("-"x (10 * ($num_players + 6)), "\n");
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix($i);
        $game_board[$i]->print();
    }
    print("\n\n");
    for (my $i = 0; $i < 8; $i += 1) {
        printCellPrefix($game_board_size - $i - 1);
        $game_board[-$i-1]->print();
        print(" "x (8 * ($num_players + 6)));
        printCellPrefix($i + 10);
        $game_board[$i+10]->print();
        print("\n\n");
    }
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix(27 - $i);
        $game_board[27-$i]->print();
    }
    print("\n");
    print("-"x (10 * ($num_players + 6)), "\n");
}

sub terminationCheck {
    if($players[0]->{money} > 0 && $players[1]->{money} > 0){
        return 1;
    }
    return 0;
}

sub throwDice {
    my $step = 0;
    for (my $i = 0; $i < $num_dices; $i += 1) {
        $step += 1 + int(rand(6));
    }
    return $step;
}

sub main {
    while (terminationCheck()){
        
        if ($cur_player->{num_rounds_in_jail} > 0){
            # Player is put to jail

            #charge current player $200
            if($cur_player->{money} < 200){
                local $Player::due = $cur_player->{money};
                $cur_player->payDue();
            }else{
                $cur_player->payDue();
            }
            $cur_player->move();   
        }else{
            printGameBoard();
            foreach my $player (@players) {
                $player->printAsset();
            }
            print "Player $cur_player->{name}’s turn.\n";

            #charge current player $200
            if($cur_player->{money} < 200){
                local $Player::due = $cur_player->{money};
                $cur_player->payDue();
            }else{
                $cur_player->payDue();
            }

            # Throw dice
            print "Pay \$500 to throw two dice? [y/n]\n";
            my $d = <STDIN>;
            chomp $d;

            while($d ne "y" and $d ne "n"){
                print "Pay \$500 to throw two dice? [y/n]\n";
                $d = <STDIN>;
                chomp $d;
            }

            my $points;
            if($d eq "y"){
                my $amount = 500 * (1 + 0.05);
                if($cur_player->{money} < $amount){
                    print "You do not have enough money to throw two dice!\n";
                    $points = throwDice();
                }else{
                    local $num_dices = 2;
                    $points = throwDice();

                    local $Player::due = 500;
                    local $Player::handling_fee_rate = 0.05;
                    $cur_player->payDue();

                }    
            }else{
                $points = throwDice();
            }
            print "Points of dice: $points\n";

            # Move player
            $cur_player->move($points);
            printGameBoard();

            # Call cell
            my $cur_position = $cur_player->{position};
            $game_board[$cur_position]->stepOn(); #dynamic typing
        }

        $cur_player_idx = 1 - $cur_player_idx;
        $cur_player = $players[$cur_player_idx];
        
    }

    my $winner_name;
    if ($players[0]->{money} <= 0){
        $winner_name = $players[1]->{name};   
    }elsif ($players[1]->{money} <= 0){
        $winner_name = $players[0]->{name};
    }
    print "Game over! winner: $winner_name.\n";
}

main();
