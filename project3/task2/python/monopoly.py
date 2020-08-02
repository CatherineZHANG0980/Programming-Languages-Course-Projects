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

import random

random.seed(0) # don't touch!

# you are not allowed to modify Player class!
class Player:
    due = 200
    income = 0
    tax_rate = 0.2
    handling_fee_rate = 0
    prison_rounds = 2

    def __init__(self, name):
        self.name = name
        self.money = 100000
        self.position = 0
        self.num_rounds_in_jail = 0

    def updateAsset(self):
        self.money += Player.income

    def payDue(self):
        self.money += Player.income * (1 - Player.tax_rate)
        self.money -= Player.due * (1 + Player.handling_fee_rate)

    def printAsset(self):
        print("Player %s's money: %d" % (self.name, self.money))

    def putToJail(self):
        self.num_rounds_in_jail = Player.prison_rounds

    def move(self, step):
        if self.num_rounds_in_jail > 0:
            self.num_rounds_in_jail -= 1
        else:
            self.position = (self.position + step) % 36



class Bank:
    def __init__(self):
        pass

    def print(self):
        print("Bank ", end='')

    def stepOn(self):

        tmp_income = Player.income
        Player.income = 2000

        cur_player.updateAsset()
        Player.income = tmp_income
        print ("You received $2000 from the Bank!")

        return

class Jail:
    def __init__(self):
        pass

    def print(self):
        print("Jail ", end='')

    def stepOn(self):

        while True:
            d = input("Pay $1000 to reduce the prison round to 1? [y/n]\n")
            if d not in ('y', 'n'):
                continue
            else:
                break

        Player.prison_rounds = 2

        if (d is 'y'):
            money = cur_player.money
            amount = 1000 * (1 + 0.1)

            if (money < amount):
                print("You do not have enough money to reduce the prison round!")
            else:
                Player.prison_rounds = 1

                tmp_due = Player.due
                tmp_handling_fee_rate = Player.handling_fee_rate

                Player.due = 1000
                Player.handling_fee_rate = 0.1
                cur_player.payDue()

                Player.due = tmp_due
                Player.handling_fee_rate = tmp_handling_fee_rate


        cur_player.putToJail()


class Land:
    land_price = 1000
    upgrade_fee = [1000, 2000, 5000]
    toll = [500, 1000, 1500, 3000]
    tax_rate = [0.1, 0.15, 0.2, 0.25]

    def __init__(self):
        self.owner = None
        self.level = 0

    def print(self):
        if self.owner is None:
            print("Land ", end='')
        else:
            print("%s:Lv%d" % (self.owner.name, self.level), end="")
    
    def buyLand(self):

        tmp_due = Player.due
        tmp_handling_fee_rate = Player.handling_fee_rate

        if (cur_player.money < self.land_price):
            print("You do not have enough money to buy the land!")
            Player.due = 0
        else:
            Player.due = self.land_price
            Player.handling_fee_rate = 0.1
            self.owner = cur_player

        cur_player.payDue()
        Player.due = tmp_due
        Player.handling_fee_rate = tmp_handling_fee_rate
    
    def upgradeLand(self):
        
        tmp_due = Player.due
        tmp_handling_fee_rate = Player.handling_fee_rate

        amount = self.upgrade_fee[self.level] * (1 + 0.1)
        if(cur_player.money < amount):
            print("You do not have enough money to upgrade the land!")
            Player.due = 0
        else:
            Player.due = self.upgrade_fee[self.level]
            Player.handling_fee_rate = 0.1

        cur_player.payDue()
        Player.due = tmp_due
        Player.handling_fee_rate = tmp_handling_fee_rate
    
    def chargeToll(self):
        
        amount = self.toll[self.level]
        if(cur_player.money < amount):
            amount = cur_player.money

        tmp_income = Player.income
        tmp_due = Player.due
        tmp_handling_fee_rate = Player.handling_fee_rate
        tmp_tax_rate = Player.tax_rate

        Player.due = amount
        cur_player.payDue()

        Player.income = amount
        Player.tax_rate = self.tax_rate[self.level]
        Player.due = 0

        self.owner.payDue()
        Player.income = tmp_income
        Player.due = tmp_due
        Player.handling_fee_rate = tmp_handling_fee_rate
        Player.tax_rate = tmp_tax_rate

    def stepOn(self):

        if (self.owner is None):
            while True:
                d1 = input("Pay $1000 to buy the land? [y/n]\n")
                if d1 not in ('y', 'n'):
                    continue
                else:
                    break

            if (d1 is 'y'):
                self.buyLand()

        elif (self.level < 3 and self.owner.name is cur_player.name):
            while True:
                d2 = input("Pay ${} to upgrade the land? [y/n]\n".format(self.upgrade_fee[self.level]))
                if d2 not in ('y', 'n'):
                    continue
                else:
                    break

            if (d2 is 'y'):
                self.upgradeLand()

        elif (self.owner.name is not cur_player.name):
            print("You need to pay player {} ${}" . format(self.owner.name, self.toll[self.level]))
            self.chargeToll()

        return



players = [Player("A"), Player("B")]
cur_player = players[0]
num_players = len(players)
cur_player_idx = 0
cur_player = players[cur_player_idx]
num_dices = 1
cur_round = 0

game_board = [
    Bank(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Jail(),
    Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(),
    Jail(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Jail(),
    Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land()
]
game_board_size = len(game_board)


def printCellPrefix(position):
    occupying = []
    for player in players:
        if player.position == position and player.money > 0:
            occupying.append(player.name)
    print(" " * (num_players - len(occupying)) + "".join(occupying), end='')
    if len(occupying) > 0:
        print("|", end='')
    else:
        print(" ", end='')


def printGameBoard():
    print("-" * (10 * (num_players + 6)))
    for i in range(10):
        printCellPrefix(i)
        game_board[i].print()
    print("\n")
    for i in range(8):
        printCellPrefix(game_board_size - i - 1)
        game_board[-i - 1].print()
        print(" " * (8 * (num_players + 6)), end="")
        printCellPrefix(i + 10)
        game_board[i + 10].print()
        print("\n")
    for i in range(10):
        printCellPrefix(27 - i)
        game_board[27 - i].print()
    print("")
    print("-" * (10 * (num_players + 6)))


def terminationCheck():

    for player in players:
        if player.money <= 0:
            return False

    return True


def throwDice():
    step = 0
    for i in range(num_dices):
        step += random.randint(1, 6)
    return step


def main():
    global cur_player
    global num_dices
    global cur_round
    global cur_player_idx

    while terminationCheck():

        if(cur_player.num_rounds_in_jail > 0):

            tmp_due = Player.due
            if (cur_player.money < Player.due):
                Player.due = cur_player.money
            cur_player.payDue()
            Player.due = tmp_due
            cur_player.move(0)

        else:
            printGameBoard()
            for player in players:
                player.printAsset()

            tmp_due = Player.due
            if (cur_player.money < Player.due):
                Player.due = cur_player.money
            cur_player.payDue()
            Player.due = tmp_due

            print("Player {}’s turn.".format(cur_player.name))

            # Throw dice
            while True:
                d1 = input("Pay $500 to throw two dice? [y/n]\n")
                if d1 not in ('y', 'n'):
                    continue
                else:
                    break

            if (d1 is 'y'):
                amount = 500 * (1 + 0.05)
                if(cur_player.money < amount):
                    print ("You do not have enough money to throw two dice!")
                else:
                    num_dices = 2

                    tmp_due = Player.due
                    tmp_handling_fee_rate = Player.handling_fee_rate

                    Player.due = 500
                    Player.handling_fee_rate = 0.05
                    cur_player.payDue()

                    Player.due = tmp_due
                    Player.handling_fee_rate = tmp_handling_fee_rate
            step = throwDice()
            num_dices = 1

            # Move player
            cur_player.move(step)
            printGameBoard()

            # Call cell
            game_board[cur_player.position].stepOn()

        cur_player_idx = 1 - cur_player_idx
        cur_player = players[cur_player_idx]

    if (players[0].money <= 0):
        winner_name = players[1].name
    else:
        winner_name = players[0].name
    print("Game over! winner: {}.".format(winner_name))


if __name__ == '__main__':
    main()
