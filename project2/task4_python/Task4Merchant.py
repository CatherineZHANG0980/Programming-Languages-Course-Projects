# ∗ CSCI3180 Principles of Programming Languages ∗
# ∗ --- Declaration --- ∗
# ∗ I declare that the assignment here submitted is original except for source
# ∗ material explicitly acknowledged. I also acknowledge that I am aware of
# ∗ University policy and regulations on honesty in academic work, and of the
# ∗ disciplinary guidelines and procedures applicable to breaches of such policy
# ∗ and regulations, as contained in the website
# ∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
# ∗ Assignment 2
# ∗ Name : ZHANG Xinyu
# ∗ Student ID : 1155091989
# ∗ Email Addr : xyzhang7@cse.cuhk.edu.hk

from Pos import Pos

class Task4Merchant():
    _elixirPrice = None
    _shieldPrice = None
    _pos = None

    def __init__(self):
        self._elixirPrice = 1
        self._shieldPrice = 2
        self._pos = Pos()

    def actionOnSoldier(self, soldier):
        purchaseEnabled = True
        while purchaseEnabled:
            choice = input("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ")

            if choice is "1":
                coin = soldier.getNumCoin()
                if coin < self._elixirPrice:
                    print("You don't have enough coins.\n")
                    purchaseEnabled = False
                else:
                    soldier.elimiCoin(self._elixirPrice)
                    soldier.addElixir()
                    purchaseEnabled = False
            elif choice is "2":
                coin = soldier.getNumCoin()
                if coin < self._shieldPrice:
                    print("You don't have enough coins.\n")
                    purchaseEnabled = False
                else:
                    soldier.elimiCoin(self._shieldPrice)
                    soldier.addDefence()
                    purchaseEnabled = False
            elif choice is "3":
                purchaseEnabled = False
            else:
                print("=> Illegal choice!\n")

    def talk(self, text):
        print("Merchant$: " + text, end="")

    def getPos(self):
        return self._pos

    def setPos(self, row, column):
        self._pos.setPos(row, column)

    def displaySymbol(self):
        print("$", end="")
