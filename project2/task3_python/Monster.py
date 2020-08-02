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


class Monster:

    def __init__(self, monsterID, healthCapacity):
        self._monsterID = monsterID
        self._healthCapacity = healthCapacity
        self._health = healthCapacity
        self._pos = Pos()
        self._dropItemList = []
        self._hintList = []

    def addDropItem(self, key):
        self._dropItemList.append(key)

    def addHint(self, monsterID):
        self._hintList.append(monsterID)

    def getMonsterID(self):
        return self._monsterID

    def getPos(self):
        return self._pos

    def setPos(self, row, column):
        self._pos.setPos(row, column)

    def getHealthCapacity(self):
        return self._healthCapacity

    def getHealth(self):
        return self._health

    def loseHealth(self):
        self._health = self._health - 10
        return True if self._health <= 0 else False

    def recover(self, healingPower):
        self._health = healingPower

    def actionOnSoldier(self, soldier):
        if self._health <= 0:
            self.talk("You had defeated me.\n\n")
        else:
            if self.requireKey(soldier.getKeys()):
                self.fight(soldier)
            else:
                self.displayHints()

    def requireKey(self, keys):
        return True if self._monsterID in keys else False

    def displayHints(self):
        hintList = "[" + ", ".join(map(str, self._hintList)) + "]"
        self.talk("Defeat Monster " + hintList + " first.\n\n")

    def fight(self, soldier):
        fightEnabled = True
        while fightEnabled:
            print("       | Monster%d | Soldier |" % self._monsterID)
            print("Health | %8d | %7d |\n" % (self._health, soldier.getHealth()))
            choice = input("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ")

            if choice is "1":
                if self.loseHealth():
                    print("=> You defeated Monster%d.\n" % self._monsterID)
                    self.dropItems(soldier)
                    fightEnabled = False
                else:
                    if soldier.loseHealth():
                        self.recover(self._healthCapacity)
                        fightEnabled = False
            elif choice is "2":
                self.recover(self._healthCapacity)
                fightEnabled = False
            elif choice is "3":
                if soldier.getNumElixirs() == 0:
                    print("=> You have run out of elixirs.\n")
                else:
                    soldier.useElixir()
            else:
                print("=> Illegal choice!\n")

    def dropItems(self, soldier):
        for item in self._dropItemList:
            soldier.addKey(item)

    def talk(self, text):
        print("Monster%d: " % self._monsterID, end="")
        print(text, end="")

    def displaySymbol(self):
        print("M", end="")
