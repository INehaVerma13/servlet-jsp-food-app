package com.tap.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Collection;

import com.tap.dao.OrderDao;
import com.tap.dao.OrderItemDao;
import com.tap.daoImpl.OrderDaoImpl;
import com.tap.daoImpl.OrderItemImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.OrderItem;
import com.tap.model.Orders;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderController extends HttpServlet {

    private OrderDao orderDao;
    private OrderItemDao orderItemDao;

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
        orderItemDao = new OrderItemImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // 1. Guard check: User authentication
        User user = (User) session.getAttribute("user");
        if (user == null) {
            req.setAttribute("error", "Please login to complete your order.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        // 2. Guard check: Active cart with items
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // 3. Extract parameters from checkout form
        String paymentMode = req.getParameter("paymentMode");
        if (paymentMode == null || paymentMode.trim().isEmpty()) {
            paymentMode = "COD";
        }

        double totalAmount = 0.0;
        String totalAmountStr = req.getParameter("totalAmount");
        if (totalAmountStr != null && !totalAmountStr.trim().isEmpty()) {
            try {
                totalAmount = Double.parseDouble(totalAmountStr);
            } catch (NumberFormatException e) {
                totalAmount = 0.0;
            }
        }

        // 4. Determine restaurantId from the first cart item
        Collection<CartItem> cartItems = cart.getItems();
        int restaurantId = 0;
        for (CartItem item : cartItems) {
            restaurantId = item.getMenu().getRestaurantId();
            break;
        }

        // 5. Construct and insert the parent Order
        Orders order = new Orders();
        order.setUserId(user.getUserId());
        order.setRestaurantId(restaurantId);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setTotalAmount(totalAmount);
        order.setStatus("Placed");
        order.setPaymentMode(paymentMode);

        int orderId = orderDao.addOrder(order);

        // 6. Insert individual items if parent order succeeded
        if (orderId > 0) {
            for (CartItem item : cartItems) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setMenuId(item.getMenu().getMenuId());
                orderItem.setTotalAmount(item.getMenu().getPrice() * item.getQuantity());

                orderItemDao.addOrderItem(orderItem);
            }

            // 7. Clear the cart from session so it cannot be re-ordered
            session.removeAttribute("cart");

            // 8. Pass order info and redirect to confirmation
            session.setAttribute("latestOrder", order);
            resp.sendRedirect(req.getContextPath() + "/orderConfirmation.jsp");
        } else {
            req.setAttribute("error", "Failed to place order. Please try again.");
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/restaurant");
    }
}