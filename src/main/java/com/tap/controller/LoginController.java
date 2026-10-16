package com.tap.controller;

import java.io.IOException;

import com.tap.dao.UserDao;
import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;
import com.tap.utility.PasswordUtil; // 1. Added import

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.trim().isEmpty() || 
            password == null || password.isEmpty()) {

            req.setAttribute("error", "Please enter both email and password!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        email = email.trim();

        UserDao userDao = new UserDaoImpl();
        User user = userDao.getUserByEmail(email);

        // 2. Verified plain password against hashed password from database
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect("restaurant");
        } else {
            req.setAttribute("error", "Invalid email or password!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}