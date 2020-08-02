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
from Cell import Cell
from Map import Map
from Task4Monster import Task4Monster
from Pos import Pos
from Task4Soldier import Task4Soldier
from Spring import Spring
from Task4Merchant import Task4Merchant


class SaveTheTribe:

    def __init__(self):
        self._map = Map()
        self._soldier = Task4Soldier()
        self._spring = Spring()
        self._monsters = []
        self._merchant = Task4Merchant()
        self._gameEnabled = True

    def initialize(self):
        for i in range(7):
            self._monsters.append(Task4Monster(i+1, random.randint(1, 4) * 10 + 30))

        self._monsters[0].setPos(4, 1)
        self._monsters[0].addDropItem(2)
        self._monsters[0].addDropItem(3)

        self._monsters[1].setPos(3, 3);
        self._monsters[1].addDropItem(3);
        self._monsters[1].addDropItem(6);
        self._monsters[1].addHint(1);
        self._monsters[1].addHint(5);

        self._monsters[2].setPos(5, 3);
        self._monsters[2].addDropItem(4);
        self._monsters[2].addHint(1);
        self._monsters[2].addHint(2);

        self._monsters[3].setPos(5, 5);
        self._monsters[3].addHint(3);
        self._monsters[3].addHint(6);

        self._monsters[4].setPos(1, 4);
        self._monsters[4].addDropItem(2);
        self._monsters[4].addDropItem(6);

        self._monsters[5].setPos(3, 5);
        self._monsters[5].addDropItem(4);
        self._monsters[5].addDropItem(7);
        self._monsters[5].addHint(2);
        self._monsters[5].addHint(5);

        self._monsters[6].setPos(4, 7);
        self._monsters[6].addDropItem(-1);
        self._monsters[6].addHint(6);

        self._map.addObject(self._monsters)

        self._soldier.setPos(1, 1)
        self._soldier.addKey(1)
        self._soldier.addKey(5)

        self._map.addObject(self._soldier)

        self._spring.setPos(7, 4)

        self._map.addObject(self._spring)

        self._merchant.setPos(7, 7)

        self._map.addObject(self._merchant)

    def start(self):
        print("=> Welcome to the desert!")
        print("=> Now you have to defeat the monsters and find the artifact to save the tribe.\n")
        while(self._gameEnabled):
            self._map.displayMap()
            self._soldier.displayInformation()
            move = input("\n=> What is the next step? (W = Up, S = Down, A = Left, D = Right.) Input: ")

            pos = self._soldier.getPos()
            newRow = oldRow = pos.getRow()
            newColumn = oldColumn = pos.getColumn()

            if move.upper() == "W":
                newRow = oldRow - 1
            elif move.upper() == "S":
                newRow = oldRow + 1
            elif move.upper() == "A":
                newColumn = oldColumn - 1
            elif move.upper() == "D":
                newColumn = oldColumn + 1
            else:
                print("=> Illegal move!\n")
                continue

            if self._map.checkMove(newRow, newColumn):
                occupiedObject = self._map.getOccupiedObject(newRow, newColumn)
                if isinstance(occupiedObject, Task4Monster) \
                        or isinstance(occupiedObject, Spring) \
                        or isinstance(occupiedObject, Task4Merchant):
                    occupiedObject.actionOnSoldier(self._soldier)
                else:
                    self._soldier.move(newRow, newColumn)
                    self._map.update(self._soldier, oldRow, oldColumn, newRow, newColumn)
                    print("\n")
            else:
                print("=> Illegal move!\n")

            if self._soldier.getHealth() <= 0:
                print("=> You died.")
                print("=> Game over.\n")
                self._gameEnabled = False

            if -1 in self._soldier.getKeys():
                print("=> You found the artifact.")
                print("=> Game over.\n")
                self._gameEnabled = False


game = SaveTheTribe()
game.initialize()
game.start()

