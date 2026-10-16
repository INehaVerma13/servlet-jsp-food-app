package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.RestaurantDao;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDaoImpl implements RestaurantDao{
	
	private static final String INSERT_RESTAURANT="insert into restaurant(name,cuisineType, deliveryTime,address, adminUserId,rating,isActive, imagePath)"+
	"values(?,?,?,?,?,?,?,?)";
	
	private static final String GET_RESTAURANT="select * from restaurant where restaurantId=?";
	private static final String UPDATE_RESTAURANT="update restaurant set name=?,cuisineType=?, deliveryTime=?,address=?, adminUserId=?,rating=?,isActive=?, imagePath=? where restaurantId=?";
	private static final String DELETE_RESTAURANT="delete from restaurant where restaurantId=?";
	private static final String GET_ALL_RESTAURANT="select*from restaurant";
	

	@Override
	public int addRestaurant(Restaurant restaurant) {
		int status=0;
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(INSERT_RESTAURANT)){
			pstmt.setString(1, restaurant.getName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3,restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setInt(5, restaurant.getAdminUserId());
			pstmt.setDouble(6, restaurant.getRating());
			pstmt.setBoolean(7, restaurant.isActive());
			pstmt.setString(8, restaurant.getImagePath());
			
			status=pstmt.executeUpdate();
			
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {
		Restaurant restaurant=null;
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(GET_RESTAURANT)){
			pstmt.setInt(1, restaurantId);
			try(ResultSet resultSet=pstmt.executeQuery()){
				if(resultSet.next()) {
					restaurant=extractRestaurantFromResultSet(resultSet);
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return restaurant;
	}

	@Override
	public int updateRestaurant(Restaurant restaurant) {
		int status=0;
		
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(UPDATE_RESTAURANT)){
			pstmt.setString(1, restaurant.getName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3,restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setInt(5, restaurant.getAdminUserId());
			pstmt.setDouble(6, restaurant.getRating());
			pstmt.setBoolean(7, restaurant.isActive());
			pstmt.setString(8, restaurant.getImagePath());
			pstmt.setInt(9, restaurant.getRestaurantId());
			
			status=pstmt.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
			
		
		return status;
	}

	@Override
	public int deleteRestaurant(int restaurantId) {
		int status=0;

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(DELETE_RESTAURANT)){
			pstmt.setInt(1, restaurantId);
			status=pstmt.executeUpdate();
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<Restaurant> getAllRestaurant() {
		List<Restaurant> restaurantList=new ArrayList<>();

		try(Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt=connection.prepareStatement(GET_ALL_RESTAURANT);
				ResultSet resultSet=pstmt.executeQuery()){
			while(resultSet.next()) {
				restaurantList.add(extractRestaurantFromResultSet(resultSet));
				}
			}
		catch(SQLException e) {
				e.printStackTrace();
			}
					
		
		return restaurantList;
	}
	
	private Restaurant extractRestaurantFromResultSet(ResultSet resultSet) throws SQLException {
		return new Restaurant(
		resultSet.getInt("restaurantId"),
		resultSet.getString("name"),
		resultSet.getString("cuisineType"),
		resultSet.getInt("deliveryTime"),
		resultSet.getString("address"),
		resultSet.getInt("adminUserId"),
		resultSet.getDouble("rating"),
		resultSet.getBoolean("isActive"),
		resultSet.getString("imagePath")
		);
		
	}
	

}
