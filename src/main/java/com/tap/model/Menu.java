package com.tap.model;

public class Menu {

	private int menuId;
	private int restaurantId;
	private String itemName;
	private String description;
	private double price;
	private boolean isAvailable;
	private String imagePath;
	private boolean isVeg;

	public Menu() {

	}

	public Menu(int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String imagePath, boolean isVeg) {
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.imagePath = imagePath;
		this.isVeg = isVeg;
	}

	public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String imagePath,boolean isVeg) {
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.imagePath = imagePath;

	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemName() {
		return itemName;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getPrice() {
		return price;
	}

	public void setIsAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getImagePath() {
		return imagePath;
	}

	public boolean isVeg() {
		return isVeg;
	}

	public void setVeg(boolean isVeg) {
		this.isVeg = isVeg;
	}

	public String toString() {
		return "Menu [menuId=" + getMenuId() + ", restaurantId=" + getRestaurantId() + ", itemName=" + getItemName()
				+ ", description=" + getDescription() + ", itemName=" + getItemName() + ", description="
				+ getDescription() + ", price=" + getPrice() + "isAvailable=" + isAvailable() + ", imagePath="
				+ getImagePath() +", isVeg="+isVeg()+"]";
	}

}
