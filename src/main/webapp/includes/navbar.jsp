<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User"%>

<header class="app-navbar">
    <a href="restaurant" class="nav-brand">
        <span class="brand-icon"><i class="fa-solid fa-fire-flame-curved"></i></span>
        Food<span class="brand-accent">Walla</span>
    </a>

    <nav class="nav-menu">
        <a href="restaurant" class="nav-link">
            <i class="fa-solid fa-house"></i> Home
        </a>
        <a href="cart" class="nav-link">
            <i class="fa-solid fa-cart-shopping"></i> Cart
        </a>

        <%
            User navUser = (User) session.getAttribute("user");
            if (navUser == null) {
        %>
            <!-- Guest State: Clean Sign In Button -->
            <a href="login" class="btn-nav-login">
                <i class="fa-regular fa-user" style="margin-right: 0.35rem;"></i> Sign In
            </a>
        <%
            } else {
        %>
            <!-- Logged-in State: Orders Link + Just the Avatar Icon + Logout -->
            <a href="orders" class="nav-link">
                <i class="fa-solid fa-clock-rotate-left"></i> Orders
            </a>
            <a href="profile.jsp" class="nav-avatar" title="View Profile">
                <i class="fa-regular fa-user"></i>
            </a>
            <a href="logout" class="nav-logout-btn">
                 Logout
            </a>
        <%
            }
        %>
    </nav>
</header>