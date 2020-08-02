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

import random
from Pos import Pos


class Soldier:
    _health = None
    _numElixirs = None
    _pos = None
    _keys = None

    def __init__(self):
        self._health = 100
        self._numElixirs = 2
        self._pos = Pos()
        self._keys = set([])

    def getHealth(self):
        return self._health

    def loseHealth(self):
        self._health = self._health - 10
        return True if self._health <= 0 else False

    def recover(self, healingPower):
        totalHealth = healingPower + self._health
        self._health = 100 if totalHealth >= 100 else totalHealth

    def getPos(self):
        return self._pos

    def setPos(self, row, column):
        self._pos.setPos(row, column)

    def move(self, row, column):
        self.setPos(row, column)

    def getKeys(self):
        return self._keys

    def addKey(self, key):
        self._keys.add(key)

    def getNumElixirs(self):
        return self._numElixirs

    def addElixir(self):
        self._numElixirs = self._numElixirs + 1

    def useElixir(self):
        self.recover(random.randint(0, 5) + 15)
        self._numElixirs = self._numElixirs - 1

    def displayInformation(self):
        keys = "[" + ", ".join(map(str, self._keys)) + "]"
        print("Health: %d." % self._health)
        print("Position (row, column): (%d, %d)." % (self._pos.getRow(), self._pos.getColumn()))
        print("Keys: " + keys + ".")
        print("Elixirs: %d." % self._numElixirs)

    def displaySymbol(self):
        print("S", end="")



