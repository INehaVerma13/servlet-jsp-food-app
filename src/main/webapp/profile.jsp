<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - FoodWalla</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- External CSS Files -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css">
</head>
<body>

    <!-- Ambient Glowing Orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>

    <!-- Modular Navbar -->
    <jsp:include page="includes/navbar.jsp" />

    <div class="profile-container">
        <%
            User user = (User) session.getAttribute("user");

            if (user != null) {
                String name = "";
                String email = "";
                String phone = "";
                String address = "";

                try { name = user.getUserName(); } catch(Exception e) {}
                try { email = user.getEmail(); } catch(Exception e) {}
                try { phone = user.getPhone(); } catch(Exception e) {
                    try { phone = user.getPhone(); } catch(Exception ex) {}
                }
                try { address = user.getAddress(); } catch(Exception e) {}

                String initial = (name != null && !name.trim().isEmpty()) 
                                 ? name.trim().substring(0, 1).toUpperCase() 
                                 : "U";
        %>
            <!-- Top Hero Banner -->
            <div class="profile-hero">
                <div class="profile-hero-left">
                    <div class="avatar-circle"><%= initial %></div>
                    <div class="user-meta">
                        <h2><%= (name != null && !name.isEmpty()) ? name : "Food Explorer" %></h2>
                        <p><i class="fa-regular fa-envelope"></i> <%= (email != null && !email.isEmpty()) ? email : "No email linked" %></p>
                    </div>
                </div>
            </div>

            <!-- Dashboard Grid -->
            <div class="profile-grid">
                <!-- Sidebar -->
                <div class="profile-sidebar">
                    <div class="sidebar-card">
                        <ul class="quick-nav-list">
                            <li class="quick-nav-item active">
                                <a href="profile.jsp">
                                    <i class="fa-regular fa-user"></i> Personal Details
                                </a>
                            </li>
                            <li class="quick-nav-item">
                                <a href="cart">
                                    <i class="fa-solid fa-basket-shopping"></i> My Active Cart
                                </a>
                            </li>
                            <li class="quick-nav-item">
                                <a href="restaurant">
                                    <i class="fa-solid fa-utensils"></i> Browse Restaurants
                                </a>
                            </li>
                        </ul>

                        <div class="stats-grid">
                            <div class="stat-box">
                                <div class="stat-number">Member</div>
                                <div class="stat-label">Status</div>
                            </div>
                            <div class="stat-box">
                                <div class="stat-number">Active</div>
                                <div class="stat-label">Account</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Form Card -->
                <div class="details-card">
                    <div class="card-header-row">
                        <div class="card-title">
                            <i class="fa-solid fa-id-card"></i> Account Information
                        </div>
                    </div>

                    <form action="profile" method="post">
                        <input type="hidden" name="action" value="updateProfile">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <div class="input-box">
                                    <i class="fa-regular fa-user"></i>
                                    <input type="text" id="name" name="name" value="<%= name %>" placeholder="Your Name" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <div class="input-box">
                                    <i class="fa-solid fa-phone"></i>
                                    <input type="tel" id="phone" name="phone" value="<%= (phone != null) ? phone : "" %>" placeholder="10-digit mobile number">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address (Registered)</label>
                            <div class="input-box">
                                <i class="fa-regular fa-envelope"></i>
                                <input type="email" id="email" name="email" value="<%= email %>" readonly style="background: #f8fafc; cursor: not-allowed;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address">Default Delivery Address</label>
                            <div class="input-box">
                                <i class="fa-solid fa-location-dot" style="top: 1.1rem;"></i>
                                <textarea id="address" name="address" placeholder="House/Flat No., Landmark, City, PIN code"><%= (address != null) ? address : "" %></textarea>
                            </div>
                        </div>

                        <button type="submit" class="btn-save">
                            Save Changes
                        </button>
                    </form>
                </div>
            </div>
        <%
            } else {
        %>
            <!-- Unauthenticated State -->
            <div class="not-logged-in-card">
                <div class="empty-icon">
                    <i class="fa-solid fa-user-lock"></i>
                </div>
                <h2 style="font-size: 1.6rem; font-weight: 800; margin-bottom: 0.5rem;">Access Denied</h2>
                <p style="color: var(--slate); font-size: 0.95rem;">Please log in to your FoodWalla account to view and update your profile details.</p>
                <a href="login.jsp" class="btn-go-login">
                    Go to Login
                </a>
            </div>
        <%
            }
        %>
    </div>

    <!-- Modular Footer -->
    <jsp:include page="includes/footer.jsp" />

</body>
</html>