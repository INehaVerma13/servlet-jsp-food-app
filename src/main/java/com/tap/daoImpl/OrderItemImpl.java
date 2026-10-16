package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDao;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemImpl implements OrderItemDao{
	
	private static final String INSERT_ORDER_ITEM=
			"insert into orderitem (orderId,menuId,totalAmount) values(?,?,?)";
	
	private static final String GET_ORDER_ITEM="select * from orderitem where orderItemId=?";
	
	private static final String UPDATE_ORDER_ITEM="update orderitem set orderId=?,menuId=?,totalAmount=? where orderItemId=?";
	
	private static final String DELETE_ORDER_ITEM="delete from orderitem where orderItemId=?";
	
	private static final String GET_ORDER_ITEMS_BY_ORDER="select* from orderitem where orderId=?";

	@Override
	public int addOrderItem(OrderItem orderItem) {
		
		int status = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getMenuId());
            preparedStatement.setDouble(3, orderItem.getTotalAmount());

            status = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {
		
		OrderItem orderItem = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItemId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    orderItem = extractOrderItemFromResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItem;
	}

	@Override
	public int updateOrderItem(OrderItem orderItem) {
		
		int status = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItem.getOrderId());
            preparedStatement.setInt(2, orderItem.getMenuId());
            preparedStatement.setDouble(3, orderItem.getTotalAmount());
            preparedStatement.setInt(4, orderItem.getOrderItemId());

            status = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
	}

	@Override
	public int deleteOrderItem(int orderItemId) {
		
		int status = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ORDER_ITEM)) {

            preparedStatement.setInt(1, orderItemId);
            status = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
	}

	@Override
	public List<OrderItem> getOrderItemByOrders(int orderId) {
		
		List<OrderItem> itemList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_ITEMS_BY_ORDER)) {

            preparedStatement.setInt(1, orderId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    itemList.add(extractOrderItemFromResultSet(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
	}
	
	private OrderItem extractOrderItemFromResultSet(ResultSet resultSet) throws SQLException {
        return new OrderItem(
            resultSet.getInt("orderItemId"),
            resultSet.getInt("orderId"),
            resultSet.getInt("menuId"),
            resultSet.getDouble("totalAmount")
        );
    }
	

}
