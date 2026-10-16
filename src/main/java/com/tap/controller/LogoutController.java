package com.tap.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Fetch current session if it exists
        HttpSession session = req.getSession(false);

        if (session != null) {
            // 2. Invalidate session to clear user, cart, and authentication credentials
            session.invalidate();
        }

        // 3. Redirect back to login page with a logged-out notification parameter
        resp.sendRedirect(req.getContextPath() + "/login.jsp?logout=true");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}