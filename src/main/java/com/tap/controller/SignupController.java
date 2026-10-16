package com.tap.controller;

import java.io.IOException;

import com.tap.dao.UserDao;
import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;
import com.tap.utility.PasswordUtil; // 1. Added import for BCrypt hashing

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String username    = req.getParameter("username");
        String password    = req.getParameter("password");
        String email       = req.getParameter("email");
        String phoneNumber = req.getParameter("phoneNumber");
        String address     = req.getParameter("address");

        // 1. Validation check for null / blank inputs
        if (username == null || username.trim().isEmpty() ||
            password == null || password.isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phoneNumber == null || phoneNumber.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {

            req.setAttribute("error", "All fields are mandatory. Please fill all details!");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
            return;
        }

        username    = username.trim();
        email       = email.trim();
        phoneNumber = phoneNumber.trim();
        address     = address.trim();

        UserDao userDao = new UserDaoImpl();

        // 2. Duplicate Email Check
        User existingUser = userDao.getUserByEmail(email);

        if (existingUser != null) {
            req.setAttribute("error", "An account with this email already exists! Please login.");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
            return;
        }

        // 3. Hash password with BCrypt before creating the User object
        String hashedPassword = PasswordUtil.hashPassword(password);

        // 4. Proceed with Registration using the hashed password
        String role = "Customer";
        User newUser = new User(username, hashedPassword, email, phoneNumber, address, role);

        int status = userDao.addUser(newUser);

        if (status > 0) {
            // Fetch registered user so the object holds the generated userId from MySQL
            User registeredUser = userDao.getUserByEmail(email);

            // Log user in immediately via session
            HttpSession session = req.getSession();
            session.setAttribute("user", (registeredUser != null) ? registeredUser : newUser);

            // Send them directly to browse restaurants
            resp.sendRedirect("restaurant");
            return;
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("signup.jsp").forward(req, resp);
        }
    }
}