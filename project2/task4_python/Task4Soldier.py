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

from Soldier import Soldier


class Task4Soldier(Soldier):
    _coin = None
    _defence = None

    def __init__(self):
        super(Task4Soldier, self).__init__()
        self._coin = 0
        self._defence = 0

    def addCoin(self):
        self._coin = self._coin + 1

    def elimiCoin(self, num):
        self._coin = self._coin - num

    def getNumCoin(self):
        return self._coin

    def addDefence(self):
        self._defence = self._defence + 5

    def loseHealth(self):
        lose = (10 - self._defence) if (10 >= self._defence) else 0
        self._health = self._health - lose
        return True if self._health <=0 else False

    def displayInformation(self):
        super(Task4Soldier, self).displayInformation()
        print("Defence: %d." % self._defence)
        print("Coins: %d." % self._coin)