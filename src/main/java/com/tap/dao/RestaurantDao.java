package com.tap.dao;

import java.util.List;

import com.tap.model.Restaurant;

public interface RestaurantDao {
	int addRestaurant(Restaurant restaurant);
	Restaurant getRestaurant(int restaurantId);
	int updateRestaurant(Restaurant restaurant);
	int deleteRestaurant(int restaurantId);
	List<Restaurant> getAllRestaurant();

}
