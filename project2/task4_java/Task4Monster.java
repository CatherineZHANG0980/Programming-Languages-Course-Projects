/*
∗ CSCI3180 Principles of Programming Languages ∗
∗ --- Declaration --- ∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
∗ Assignment 2
∗ Name : ZHANG Xinyu
∗ Student ID : 1155091989
∗ Email Addr : xyzhang7@cse.cuhk.edu.hk 
*/

import java.util.ArrayList;
import java.util.Scanner;

public class Task4Monster extends Monster{
	private ArrayList<Integer> dropItemList;
	private int monsterID;
	private int health;
	private int healthCapacity;

	public Task4Monster(int monsterID, int healthCapacity) {
		super(monsterID, healthCapacity);
		this.monsterID = monsterID;
	    this.healthCapacity = healthCapacity;
	    this.health = healthCapacity;
	    this.dropItemList = new ArrayList<Integer>();
	}
	
	public void actionOnSoldier(Task4Soldier soldier) {
	    if (this.health <= 0) {
	      this.talk("You had defeated me.%n%n");
	    } else {
	      if (this.requireKey(soldier.getKeys())) {
	        this.fight(soldier);
	      } else {
	        this.displayHints();
	      }
	    }
	}
	
	public void fight(Task4Soldier soldier) {
	    boolean fightEnabled = true;

	    while (fightEnabled) {
	      System.out.printf("       | Monster%d | Soldier |%n", this.monsterID);
	      System.out.printf("Health | %8d | %7d |%n%n", this.health, ((Task4Soldier)soldier).getHealth());
	      System.out.printf("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ");

	      Scanner sc = new Scanner(System.in);

	      String choice = sc.nextLine();

	      if (choice.equalsIgnoreCase("1")) {
	        if (this.loseHealth()) {
	          System.out.printf("=> You defeated Monster%d.%n%n", this.monsterID);
	          this.dropItems(soldier);
	          fightEnabled = false;
	        } else {
	          if (((Task4Soldier) soldier).loseHealth()) {
	            this.recover(this.healthCapacity);
	            fightEnabled = false;
	          }
	        }
	      } else if (choice.equalsIgnoreCase("2")) {
	        this.recover(this.healthCapacity);
	        fightEnabled = false;
	      } else if (choice.equalsIgnoreCase("3")) {
	        if (soldier.getNumElixirs() == 0) {
	          System.out.printf("=> You have run out of elixirs.%n%n");
	        } else {
	          soldier.useElixir();
	        }
	      } else {
	        System.out.printf("=> Illegal choice!%n%n");
	      }
	    }
	  }

	public void dropItems(Task4Soldier soldier) {
	    for (Integer item : this.dropItemList) {
	      soldier.addKey(item);
	    }
	    soldier.addCoin();
	}
	
	public void addDropItem(int key) {
	    this.dropItemList.add(key);
	}
	
	public boolean loseHealth() {
		this.health -= 10;
		return this.health <= 0;
	}

}
