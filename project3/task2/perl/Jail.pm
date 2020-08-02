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

use strict;
use warnings;
require "./Player.pm";

package Jail;
sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

sub print {
    print("Jail ");
}

sub stepOn {
    my $self = shift;

    print "Pay \$1000 to reduce the prison round to 1? [y/n]\n";
    my $d = <STDIN>;
    chomp $d;

    while($d ne "y" and $d ne "n"){
        print "Pay \$1000 to reduce the prison round to 1? [y/n]\n";
        $d = <STDIN>;
        chomp $d;
    }

    if ($d eq "y"){
        my $money = $main::cur_player->{money};
        my $amount = 1000 * (1 + 0.1);

        if ($money < $amount){
            print "You do not have enough money to reduce the prison round!\n";
            $main::cur_player->putToJail();
        }else{
            # reduce prison round to 1
            local $Player::prison_rounds = 1;
            $main::cur_player->putToJail();

            local $Player::due = 1000;
            local $Player::handling_fee_rate = 0.1;
            $main::cur_player->payDue();
        }
    }else{
        $main::cur_player->putToJail();
    }

}

1;
