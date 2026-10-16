package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDao;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDaoImpl implements MenuDao{
	
	private static final String INSERT_MENU="insert into menu(restaurantId,itemName,description,price,isAvailable,imagePath,isVeg)"+
	"values(?,?,?,?,?,?,?)";
	private static final String GET_MENU="select *from menu where menuId=?";
			
    private static final String UPDATE_MENU="update menu set restaurantId=?,itemName=?,description=?,price=?,isAvailable=?,imagePath=?,isVeg = ? where menuId=?";
					
    private static final String DELETE_MENU="delete from menu where menuId=?";
							
    private static final String GET_MENUS_BY_RESTAURANT="select* from menu where restaurantId=?";
	
    
	   
    @Override
	    public int addMenu(Menu menu) {
	        int status = 0;
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_MENU)) {

	            preparedStatement.setInt(1, menu.getRestaurantId());
	            preparedStatement.setString(2, menu.getItemName());
	            preparedStatement.setString(3, menu.getDescription());
	            preparedStatement.setDouble(4, menu.getPrice());
	            preparedStatement.setBoolean(5, menu.isAvailable());
	            preparedStatement.setString(6, menu.getImagePath());
	            preparedStatement.setBoolean(7, menu.isVeg());

	            status = preparedStatement.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return status;
	    }

	    @Override
	    public Menu getMenu(int menuId) {
	        Menu menu = null;
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(GET_MENU)) {

	            preparedStatement.setInt(1, menuId);
	            try (ResultSet resultSet = preparedStatement.executeQuery()) {
	                if (resultSet.next()) {
	                    menu = extractMenuFromResultSet(resultSet);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return menu;
	    }

	    @Override
	    public int updateMenu(Menu menu) {
	        int status = 0;
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_MENU)) {

	            preparedStatement.setInt(1, menu.getRestaurantId());
	            preparedStatement.setString(2, menu.getItemName());
	            preparedStatement.setString(3, menu.getDescription());
	            preparedStatement.setDouble(4, menu.getPrice());
	            preparedStatement.setBoolean(5, menu.isAvailable());
	            preparedStatement.setString(6, menu.getImagePath());
	            preparedStatement.setBoolean(7, menu.isVeg());
	            preparedStatement.setInt(8, menu.getMenuId());

	            status = preparedStatement.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return status;
	    }

	    @Override
	    public int deleteMenu(int menuId) {
	        int status = 0;
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_MENU)) {

	            preparedStatement.setInt(1, menuId);
	            status = preparedStatement.executeUpdate();

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return status;
	    }

	    @Override
	    public List<Menu> getAllMenusByRestaurant(int restaurantId) {
	        List<Menu> menuList = new ArrayList<>();
	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(GET_MENUS_BY_RESTAURANT)) {

	            preparedStatement.setInt(1, restaurantId);
	            try (ResultSet resultSet = preparedStatement.executeQuery()) {
	                while (resultSet.next()) {
	                    menuList.add(extractMenuFromResultSet(resultSet));
	                }
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return menuList;
	    }

	    private Menu extractMenuFromResultSet(ResultSet resultSet) throws SQLException {
	        return new Menu(
	            resultSet.getInt("menuId"),
	            resultSet.getInt("restaurantId"),
	            resultSet.getString("itemName"),
	            resultSet.getString("description"),
	            resultSet.getDouble("price"),
	            resultSet.getBoolean("isAvailable"),
	            resultSet.getString("imagePath"),
	            resultSet.getBoolean("isVeg")
	        );
	    }
	
	
	
	
	
	
	

}
