package com.tap.controller;

import java.io.IOException;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.daoImpl.OrderDaoImpl;
import com.tap.model.Orders;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersHistoryController extends HttpServlet {

    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // 1. Guard check: Must be logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            req.setAttribute("error", "Please sign in to view your orders.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        // 2. Fetch all orders for this user
        List<Orders> orderList = orderDao.getAllOrdersByUser(user.getUserId());
        req.setAttribute("orderList", orderList);

        // 3. Forward to orders.jsp
        req.getRequestDispatcher("orders.jsp").forward(req, resp);
    }
}