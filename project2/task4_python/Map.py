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

from Monster import Monster
from Cell import Cell
from Soldier import Soldier
from Spring import Spring


class Map:
    _Cell = None

    def __init__(self):
        self._Cell = [[Cell() for i in range(7)] for j in range(7)]

    def addObject(self, object):
        if isinstance(object, list):
            for monster in object:
                pos = monster.getPos()
                self._Cell[pos.getRow() - 1][pos.getColumn() - 1].setOccupiedObject(monster)
        else:
            pos = object.getPos()
            if pos != None:
                self._Cell[pos.getRow() - 1][pos.getColumn() - 1].setOccupiedObject(object)

    def displayMap(self):
        print("   | 1 | 2 | 3 | 4 | 5 | 6 | 7 |")
        print("--------------------------------")
        for i in range(7):
            print(" %d |" % (i+1), end="")
            for j in range(7):
                occupiedObject = self._Cell[i][j].getOccupiedObject()
                if occupiedObject != None:
                    print(" ",end="")
                    occupiedObject.displaySymbol()
                    print(" |", end="")
                else:
                    print("   |", end="")
            print("")
            print("--------------------------------")
        print("")

    def getOccupiedObject(self, row, column):
        return self._Cell[row - 1][column - 1].getOccupiedObject()

    def checkMove(self, row, column):
        return ((row >= 1 and row <= 7) and (column >= 1 and column <= 7))

    def update(self, soldier, oldRow, oldColumn, newRow, newColumn):
        self._Cell[oldRow - 1][oldColumn - 1].setOccupiedObject(None)
        self._Cell[newRow - 1][newColumn - 1].setOccupiedObject(soldier)












