package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.model.Orders;
import com.tap.utility.DBConnection;

public class OrderDaoImpl implements OrderDao{
	
	private static final String INSERT_ORDER="insert into orders (userId, restaurantId, orderDate, totalAmount,status,paymentMode)"+
			"values (?,?,?,?,?,?)";
	private static final String GET_ORDER="select* from orders where orderId=?";
	
	private static final String UPDATE_ORDER="update orders set userId=?,restaurantId=?,orderDate=?,totalAmount=?,status=?,paymentMode=? where orderId=?";
	
	private static final String DELETE_ORDER="delete from orders where orderId=?";
	
	private static final String GET_ORDERS_BY_USER="select * from orders where userId=?";

	@Override
	public int addOrder(Orders order) {
		
		int generatedOrderId = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setTimestamp(3, order.getOrderDate());
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMode());

            int affectedRows = preparedStatement.executeUpdate();

            // Retrieve the generated orderId to link with OrderItems
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedOrderId = generatedKeys.getInt(1);
                        order.setOrderId(generatedOrderId);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedOrderId;
	}

	@Override
	public Orders getOrder(int orderId) {
		
		Orders order = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER)) {

            preparedStatement.setInt(1, orderId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    order = extractOrderFromResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
	}

	@Override
	public int updateOrder(Orders order) {
		
		int status = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setTimestamp(3, order.getOrderDate());
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMode());
            preparedStatement.setInt(7, order.getOrderId());

            status = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
	}

	@Override
	public int deleteOrder(int orderId) {
		
		
		int status = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ORDER)) {

            preparedStatement.setInt(1, orderId);
            status = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
	}

	@Override
	public List<Orders> getAllOrdersByUser(int userId) {
		
		List<Orders> orderList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDERS_BY_USER)) {

            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    orderList.add(extractOrderFromResultSet(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
	}
	
	private Orders extractOrderFromResultSet(ResultSet resultSet) throws SQLException {
        return new Orders(
            resultSet.getInt("orderId"),
            resultSet.getInt("userId"),
            resultSet.getInt("restaurantId"),
            resultSet.getTimestamp("orderDate"),
            resultSet.getDouble("totalAmount"),
            resultSet.getString("status"),
            resultSet.getString("paymentMode")
        );
    }

}
