package com.tap.dao;

import java.util.List;

import com.tap.model.Orders;

public interface OrderDao {
	int addOrder(Orders order);
	Orders getOrder(int orderId);
	int updateOrder(Orders order);
	int deleteOrder(int orderId);
	List<Orders>getAllOrdersByUser(int userId);

}
