package com.tap.model;

public class Restaurant {
	
	private int restaurantId;
	private String name;
	private String cuisineType;
	private int deliveryTime;
	private String address;
	private int adminUserId;
	private double rating;
	private boolean isActive;
	private String imagePath;
	
	public Restaurant() {
		
	}
	
	public Restaurant(String name, String cuisineType, int deliveryTime, String address, int adminUserId, double rating, boolean isActive, String imagePath)
	{
		this.name=name;
		this.cuisineType=cuisineType;
		this.deliveryTime=deliveryTime;
		this.address=address;
		this.adminUserId=adminUserId;
		this.rating=rating;
		this.isActive=isActive;
		this.imagePath=imagePath;
				
	}
	
	public Restaurant(int restaurantId,String name, String cuisineType, int deliveryTime, String address, int adminUserId, double rating, boolean isActive, String imagePath)
	{
		this.restaurantId=restaurantId;
		this.name=name;
		this.cuisineType=cuisineType;
		this.deliveryTime=deliveryTime;
		this.address=address;
		this.adminUserId=adminUserId;
		this.rating=rating;
		this.isActive=isActive;
		this.imagePath=imagePath;
				
	}
	
	public void setRestaurantId(int restaurantId)
	{
		this.restaurantId=restaurantId;
	}
	
	public int getRestaurantId()
	{
		return restaurantId;
	}
	
	public void setName(String name)
	{
		this.name=name;
	}
	
	public String getName()
	{
		return name;
	}
	
	public void setCuisineType(String cuisineType)
	{
		this.cuisineType=cuisineType;
	}
	
	public String getCuisineType()
	{
		return cuisineType;
	}
	
	
	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime=deliveryTime;
	}
	
	public int getDeliveryTime()
	{
		return deliveryTime;
	}
	
	public void setAddress(String address)
	{
		this.address=address;
	}
	
	public String getAddress() 
	{
		return address;
	}
	
	
	public void setAdminUserId(int adminUserId)
	{
		this.adminUserId=adminUserId;
	}
	
	
	public int getAdminUserId()
	{
		return adminUserId;
	}
	
	public void setRating(double rating)
	{
		this. rating= rating;
	}
	
	public double getRating()
	{
		return  rating;
	}
	
	public void setActive(boolean isActive)
	{
		this.isActive=isActive;
	}
	
	public boolean isActive()
	{
		return isActive;
	}
	
	
	public void setImagePath(String imagePath)
	{
		this.imagePath=imagePath;
	}
	
	public String getImagePath()
	{
		return imagePath;
	}
	
	@Override
	public String toString()
	{
		return "Restaurant [restaurantId="+ getRestaurantId() +" , name="+getName()+" , CuisineType="+getCuisineType()+" , deliveryTime="+getDeliveryTime()+", address="+getAddress()+", adminUserId="+getAdminUserId()+", rating="+getRating()+", isActive="+isActive()+", imagePath="+getImagePath()+"]";
	}
}
