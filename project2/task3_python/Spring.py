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
from Soldier import Soldier


class Spring:
    _numChance = None
    _healingPower = None
    _pos = None

    def __init__(self):
        self._numChance = 1
        self._healingPower = 100
        self._pos = Pos()

    def setPos(self, row, column):
        self._pos.setPos(row, column)

    def getPos(self):
        return self._pos

    def actionOnSoldier(self, soldier):
        self.talk()
        if self._numChance == 1:
            soldier.recover(self._healingPower)
            self._numChance = self._numChance - 1

    def talk(self):
        print("Spring@: You have %d chance to recover 100 health.\n" % self._numChance)

    def displaySymbol(self):
        print("@", end="")