# * CSCI3180 Principles of Programming Languages ∗
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

use strict;
use warnings;

package Game;
use MannerDeckStudent; 
use Player;

sub new {
	my $class = shift @_;

    my $deck = MannerDeckStudent->new();
    my @cards = ();
    my @players = ();
    
    my $self = {
        _deck => $deck,
        _players => \@players,
        _cards => \@cards,
    };
    return bless $self, $class;
}

sub setPlayers {
    my $self = shift @_;
    my $players_name = shift @_;
    my $players = $self->{_players};
    my $players_num = @$players_name;

    if ($players_num == 0 || 52 % $players_num != 0){
        print "Error: cards' number 52 can not be divided by players number $players_num!\n";
        return undef;
    }

    print "There $players_num players in the game:\n";

    for my $name (@$players_name){
        print "$name ";
        my $player = Player->new($name);
        push @$players, $player;
    }
    print "\n";
}

sub getReturn {
    my $self = shift @_;
    my $cards = $self->{_cards};
    my $cards_num = @$cards;
    my $rt = 0;

    #last card
    my $hook = $$cards[$cards_num - 1];

    if ($cards_num != 1 && $hook eq "J"){
        $rt = $cards_num;
    }elsif ($cards_num != 1){
        for my $i (0..$cards_num-2){
            if ($$cards[$i] eq $hook){
                $rt =  $cards_num - $i;
                last;
            }
        }
    }
    
    return $rt;
}

sub showCards {
	my $self = shift @_;
    my @cards = @{$self->{_cards}};
    print (join(" ", @cards), "\n");
}

sub startGame {
    my $self = shift @_;
    
    #player
    my @players = @{$self->{_players}};
    my $players_num = @players;
    
    #deck
    my $deck = $self->{_deck};
    my $cards = $self->{_cards};

    #shuffle and dispatch cards
    $deck->shuffle();
    my @aveCards = $deck->AveDealCards($players_num);
    for my $i (0..$players_num-1){
        my $players_cards = shift @aveCards;
        for my $card (@$players_cards){
            $players[$i]->getCards($card);
        }
    }

    print "\nGame begin!!!\n";

    my %turn_num = map {$_ => 0} @players;

    #deal cards
    while (1){
        #player
        my $currentPlayer = shift @players;
        my $name = $currentPlayer->{name};
        my $player_cards_num = $currentPlayer->numCards();
        $turn_num{$currentPlayer}++;

        #deck
        my $cards_num = @$cards;

        #check win
        $players_num = @players;
        if ($players_num == 0){
            print "\nWinner is $name in game $turn_num{$currentPlayer}\n";
            last;
        }

        #take a card
        print "\nPlayer $name has $player_cards_num cards before deal.\n";
        print "=====Before player's deal=======\n";
        $self->showCards();
        print "================================\n";
        my $card = $currentPlayer->dealCards();
        
        #add to desktop card stack
        push @$cards, $card;

        #take cards from deck
        my $rt_num = $self->getReturn();
        for my $i (0..$rt_num - 1){
            my $popCard = pop @$cards;
            $currentPlayer->getCards($popCard);
        }

        print "=====After player's deal=======\n";
        $self->showCards();
        print "================================\n";

        #check if the current player is out
        $player_cards_num = $currentPlayer->numCards();
        print "Player $name has $player_cards_num cards after deal.\n";

        if ($player_cards_num != 0){
            push @players, $currentPlayer;
        }else{
            print "Player $name has no cards, out!\n";
        }

    }
}

return 1;
