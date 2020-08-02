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

import java.util.HashSet;
import java.util.Random;

public class Task4Soldier extends Soldier{
	private int health; 
	private int coin;
	private int defence;
	private int numElixirs;
	private Pos pos;
	private HashSet<Integer> keys;

	public Task4Soldier() {
		super();
		this.health = 100;
	    this.pos = new Pos();
	    this.keys = new HashSet<Integer>();
	    this.coin = 0;
	    this.defence = 0;
	    this.numElixirs = 2;
	}
	
	public void addCoin() {
		this.coin += 1;
	}
	
	public void elimiCoin(int substractNum) {
		this.coin -= substractNum;
	}
	
	public int getNumCoin() {
		return this.coin;
	}
	
	public void addDefence() {
		this.defence += 5;
	}
	
	public int getHealth() {
	    return this.health;
	}
	
	public boolean loseHealth() {
		int lose = (10 >= this.defence) ? (10 - this.defence) : 0;
		this.health -= lose;
		return this.health <= 0;
	}
	
	public void recover(int healingPower) {
	    /* Soldier's health cannot exceed capacity. */
	    int totalHealth = healingPower + this.health;
	    this.health = totalHealth >= 100 ? 100 : totalHealth;
	}
	
	public Pos getPos() {
	    return this.pos;
	}

	public void setPos(int row, int column) {
	    this.pos.setPos(row, column);
	}
	  
	public HashSet<Integer> getKeys() {
	    return this.keys;
	}

	public void addKey(int key) {
	    this.keys.add(key);
	}
	
	public int getNumElixirs() {
	    return this.numElixirs;
	}
	
	public void addElixir() {
		this.numElixirs += 1;
	}
	
	public void useElixir() {
		Random random = new Random();
		this.recover(random.nextInt(6) + 15);
		this.numElixirs -= 1;
	}

	
	public void displayInformation() {
	    System.out.printf("Health: %d.%n", this.health);
	    System.out.printf("Position (row, column): (%d, %d).%n", this.pos.getRow(), this.pos.getColumn());
	    System.out.printf("Keys: " + this.keys + ".%n");
	    System.out.printf("Elixirs: %d.%n", this.numElixirs);
	    System.out.printf("Defence: %d.%n", this.defence);
	    System.out.printf("Coins: %d.%n", this.coin);
	}
	
	
}
