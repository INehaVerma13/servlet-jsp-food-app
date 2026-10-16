package com.tap.controller;

import java.io.IOException;

import com.tap.dao.MenuDao;
import com.tap.daoImpl.MenuDaoImpl;
import com.tap.model.Cart;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("cart.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // 1. CLEAR MUST BE HANDLED FIRST (has no menuId)
        if ("clear".equals(action)) {
            cart.clear();
            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // 2. Parse menuId for add, resetAndAdd, update, remove
        int menuId = Integer.parseInt(req.getParameter("menuId"));

        // 3. NEW: Triggered when user clicks "YES, START AFRESH"
        if ("resetAndAdd".equals(action)) {
            cart.clear(); // Clears previous restaurant items
            MenuDao menuDao = new MenuDaoImpl();
            Menu menu = menuDao.getMenu(menuId);

            if (menu != null && menu.isAvailable()) {
                cart.addItem(menu);
                session.setAttribute("cart", cart);
            }
            resp.sendRedirect(req.getContextPath() + "/menu?restaurantId=" + menu.getRestaurantId());
            return;
        }

        // 4. ADD ACTION
        if ("add".equals(action)) {
            MenuDao menuDao = new MenuDaoImpl();
            Menu menu = menuDao.getMenu(menuId);

            if (menu != null && menu.isAvailable()) {
                boolean added = cart.addItem(menu);

                if (added) {
                    session.setAttribute("cart", cart);
                    resp.sendRedirect(req.getContextPath() + "/menu?restaurantId=" + menu.getRestaurantId());
                } else {
                    // Added pendingMenuId so the popup modal knows which item to add on confirm
                    resp.sendRedirect(req.getContextPath() + "/menu?restaurantId=" + menu.getRestaurantId()
                            + "&cartError=differentRestaurant&pendingMenuId=" + menuId);
                }
            }
        } else if ("update".equals(action)) {
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            MenuDao menuDao = new MenuDaoImpl();
            Menu menu = menuDao.getMenu(menuId);
            int restaurantId = (menu != null) ? menu.getRestaurantId() : cart.getRestaurantId();

            cart.updateQuantity(menuId, quantity);
            session.setAttribute("cart", cart);

            String source = req.getParameter("source");
            if ("menu".equals(source)) {
                resp.sendRedirect(req.getContextPath() + "/menu?restaurantId=" + restaurantId);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }

        } else if ("remove".equals(action)) {
            cart.removeItem(menuId);
            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}