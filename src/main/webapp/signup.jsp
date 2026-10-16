<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - FoodWalla</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- External Modular CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/login.css">
</head>
<body>

    <!-- Ambient Glowing Orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>

    <!-- Minimal Header Navigation -->
    <header class="auth-nav">
        <a href="restaurant" class="auth-logo">
            <i class="fa-solid fa-fire-flame-curved"></i> Food<span>Walla</span>
        </a>
        <a href="restaurant" class="auth-nav-link">
            <i class="fa-solid fa-arrow-left"></i> Back to Explore
        </a>
    </header>

    <!-- Sign Up Card Container -->
    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-card-head">
                <h2>Create an Account</h2>
                <p>Sign up in seconds to start ordering your favorites.</p>
            </div>

            <!-- Dynamic Feedback Alerts from RegisterServlet -->
            <%
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
                if (error != null && !error.trim().isEmpty()) {
            %>
                <div class="auth-alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><%= error %></span>
                </div>
            <%
                } else if (message != null && !message.trim().isEmpty()) {
            %>
                <div class="auth-alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <span><%= message %></span>
                </div>
            <%
                }
            %>

            <!-- Form: Submits directly to your RegisterServlet (@WebServlet("/signup")) -->
            <form action="signup" method="post">

                <div class="form-group">
                    <label for="username">User Name</label>
                    <div class="input-wrap">
                        <i class="fa-regular fa-user"></i>
                        <input type="text" id="username" name="username" placeholder="e.g. rahul_sharma" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrap">
                        <i class="fa-regular fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="name@example.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phoneNumber">Mobile Number</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-phone"></i>
                        <input type="tel" id="phoneNumber" name="phoneNumber" pattern="[0-9]{10}" placeholder="10-digit mobile number" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Delivery Address</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-location-dot"></i>
                        <input type="text" id="address" name="address" placeholder="Flat, Area, Landmark, City" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="At least 6 characters" required>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    Sign Up
                </button>
            </form>

            <!-- Bottom Prompt to Login -->
            <div class="auth-switch-prompt">
                Already have an account? 
                <a href="login.jsp" class="auth-link-highlight">Login</a>
            </div>
        </div>
    </div>

    <footer class="auth-footer">
        &copy; <%= java.time.Year.now().getValue() %> FoodWalla Inc. All rights reserved.
    </footer>

</body>
</html>