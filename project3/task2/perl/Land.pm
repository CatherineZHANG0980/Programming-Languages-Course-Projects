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
package Land;

sub new {
    my $class = shift;
    my $self  = {
        owner => undef,
        level => 0,
    };
    bless $self, $class;
    return $self;
}

sub print {
    my $self = shift;
    if (!defined($self->{owner})) {
        print("Land ");
    } else {
        print("$self->{owner}->{name}:Lv$self->{level}");
    }
}

sub buyLand {

    my $self = shift;
    my $owner = shift;

    my $money = $owner->{money};
    my $amount = 1000 * (1 + 0.1);

    if ($money < $amount){
        print "You do not have enough money to buy the land!\n";
    }else{
        local $Player::due = 1000;
        local $Player::handling_fee_rate = 0.1;
        $owner->payDue();

        $self->{owner} = $owner;
    }

}

sub upgradeLand {

    my $self = shift;
    my $upgrade_fee = shift;

    my $money = $main::cur_player->{money};
    my $level = $self->{level};

    if($money < $upgrade_fee){
        print "You do not have enough money to upgrade the land!\n";
    }elsif ($level == 0){
        local $Player::due = 1000;
        local $Player::handling_fee_rate = 0.1;
        $self->{level} += 1;

        $main::cur_player->payDue();

    }elsif ($level == 1){
        local $Player::due = 2000;
        local $Player::handling_fee_rate = 0.1;
        $self->{level} += 1;

        $main::cur_player->payDue();

    }elsif ($level == 2){
        local $Player::due = 5000;
        local $Player::handling_fee_rate = 0.1;
        $self->{level} += 1;

        $main::cur_player->payDue();     
    }

}

sub chargeToll {

    my $self = shift;
    my $amount = shift;
    my $level = $self->{level}; 

    local $Player::due = $amount;
    $main::cur_player->payDue();

    if ($level == 0){

        if($amount < 500){
            local $Player::due = 0;
            local $Player::income = $amount;
            local $Player::tax_rate = 0.1;
            
            $self->{owner}->payDue();
        }else{
            local $Player::due = 0;
            local $Player::income = 500;
            local $Player::tax_rate = 0.1;
            
            $self->{owner}->payDue();
        }
        
    }elsif ($level == 1){

        if($amount < 1000){
            local $Player::due = 0;
            local $Player::income = $amount;
            local $Player::tax_rate = 0.15;
            
            $self->{owner}->payDue();
        }else{
            local $Player::due = 0;
            local $Player::income = 1000;
            local $Player::tax_rate = 0.15;
            
            $self->{owner}->payDue();
        }   
        
    }elsif ($level == 2){

        if($amount < 1500){
            local $Player::due = 0;
            local $Player::income = $amount;
            local $Player::tax_rate = 0.2;
            
            $self->{owner}->payDue();
        }else{
            local $Player::due = 0;
            local $Player::income = 1500;
            local $Player::tax_rate = 0.2;
            
            $self->{owner}->payDue();
        }    
        
    }elsif ($level == 3){

        if($amount < 3000){
            local $Player::due = 0;
            local $Player::income = $amount;
            local $Player::tax_rate = 0.25;
            
            $self->{owner}->payDue();
        }else{
            local $Player::due = 0;
            local $Player::income = 3000;
            local $Player::tax_rate = 0.25;
            
            $self->{owner}->payDue();
        }   
    }   

}

sub stepOn {
    my $self = shift;
    my $level = $self->{level};
    my $owner = $self->{owner};
    my $money = $main::cur_player->{money};

    if (!defined($self->{owner})){
        print "Pay \$1000 to buy the land? [y/n]\n";
        my $d = <STDIN>;
        chomp $d;

        while($d ne "y" and $d ne "n"){
            print "Pay \$1000 to buy the land? [y/n]\n";
            $d = <STDIN>;
            chomp $d;
        }

        if ($d eq "y"){
            $self->buyLand($main::cur_player);
        }

    }else{
        my $owner_name = $owner->{name};

        if ($level < 3 && $owner_name eq $main::cur_player->{name}){
            my $upgrade_fee = 0;

            if ($level == 0){
                $upgrade_fee = 1000;
            }elsif ($level == 1){
                $upgrade_fee = 2000;
            }elsif ($level == 2){
                $upgrade_fee = 5000;
            }

            print "Pay \$$upgrade_fee to upgrade the land? [y/n]\n";
            my $d = <STDIN>;
            chomp $d;

            while($d ne "y" and $d ne "n"){
                print "Pay \$$upgrade_fee to upgrade the land? [y/n]\n";
                $d = <STDIN>;
                chomp $d;
            }

            $upgrade_fee = $upgrade_fee * (1 + 0.1);

            if($d eq "y"){
                $self->upgradeLand($upgrade_fee);
            }
        
        }elsif ($owner_name ne $main::cur_player->{name}){
            my $amount = 0;

            if ($level == 0){
                $amount = 500;
            }elsif ($level == 1){
                $amount = 1000;
            }elsif ($level == 2){
                $amount = 1500;
            }elsif ($level == 3){
                $amount = 3000;
            }    

            print "You need to pay player $owner_name \$$amount\n";

            if($money < $amount){
                $amount = $money;
            }         
            $self->chargeToll($amount);
        }
    }
}
1;