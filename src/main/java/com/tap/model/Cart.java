package com.tap.model;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
	private Map<Integer,CartItem> items;
	private int restaurantId;
	public Cart()
	{
		items=new LinkedHashMap<>();
		restaurantId=0;
		
	}
	
	public boolean addItem(Menu menu)
	{
		if(items.isEmpty())
		{
			restaurantId=menu.getRestaurantId();
		}
		
		if (restaurantId != menu.getRestaurantId()) {
		    return false;
		}
		
		if(items.containsKey(menu.getMenuId())) {
			CartItem existingItem=items.get(menu.getMenuId());
			existingItem.setQuantity(existingItem.getQuantity()+1);
		}
		else {
			CartItem cartItem=new CartItem(menu,1);
			items.put(menu.getMenuId(),cartItem);
		}
		return true;
	}
	
	public void updateQuantity(int menuId,int quantity)
	{
		if(items.containsKey(menuId))
		{
			if(quantity<=0)
			{
				removeItem(menuId);
			}
			
			else {
				CartItem cartItem =items.get(menuId);
				cartItem.setQuantity(quantity);
			}
		}
	}
	
	public void removeItem(int menuId)
	{
		items.remove(menuId);
		
		if(items.isEmpty())
		{
			restaurantId=0;
		}
	}
	
	public Collection<CartItem> getItems() {
		return items.values();
	}
	
	public double getTotalAmount()
	{
		double total=0;
		
		for(CartItem item: items.values()) {
			total +=item.getSubTotal();
		}
		return total;
	}
	
	public int getTotalQuantity()
	{
		int totalQuantity=0;
		
		for(CartItem item: items.values()) {
			totalQuantity +=item.getQuantity();
		}
		return totalQuantity;
	}
	
	public int getRestaurantId() {
		return restaurantId;
	}
	
	public boolean isEmpty()
	{
		return items.isEmpty();
	}
	
	public void clear() {
		items.clear();
		restaurantId=0;
	}
	
	

}
