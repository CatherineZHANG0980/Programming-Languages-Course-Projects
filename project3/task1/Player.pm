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
 
package Player;
sub new {
    my $class = shift @_;
    my @cards = ();
	my $self = {
        name => shift @_,
		cards => \@cards,
	};
    return bless $self, $class;
}

sub getCards {
    my $self = shift @_;
    my $card = shift @_;
    my $cards = $self->{cards};
    push @$cards, $card;
}

sub dealCards {
    my $self = shift @_;
    my $name = $self->{name};
    my $cards = $self->{cards};
    my $cards_num = @$cards;

    my $rt = shift @$cards;
    print "$name ==> card $rt\n";

    $cards_num = @$cards;
    return $rt;
}

sub numCards {
    my $self = shift @_;
    my @cards = @{$self->{cards}};
    my $cards_num = @cards;
    return $cards_num;
}

return 1;