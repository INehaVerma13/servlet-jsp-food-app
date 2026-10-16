<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.tap.model.Orders"%>
<%@ page import="com.tap.model.User"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Orders> orderList = (List<Orders>) request.getAttribute("orderList");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | FoodWalla</title>
    
    <!-- Icons & Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <!-- Stylesheets -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/orders.css">
</head>
<body>

    <!-- Ambient Glowing Orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>

    <!-- Navigation Bar -->
    <jsp:include page="/includes/navbar.jsp" />

    <main class="orders-container">
        
        <!-- Header Title Banner -->
        <div class="orders-head">
            <div>
                <h1 class="orders-title">My Orders</h1>
                <p class="orders-subtitle">Track current shipments and view previous deliveries</p>
            </div>
            <% if (orderList != null && !orderList.isEmpty()) { %>
                <div class="orders-count-badge">
                    <span><%= orderList.size() %> Total Orders</span>
                </div>
            <% } %>
        </div>

        <%
            if (orderList == null || orderList.isEmpty()) {
        %>
            <!-- Empty State -->
            <div class="empty-orders-card">
                <div class="empty-icon-wrap">
                    <i class="fa-solid fa-box-open"></i>
                </div>
                <h2>No Orders Placed Yet</h2>
                <p>Looks like you haven't ordered anything yet. Delicious dishes are just a click away!</p>
                <a href="restaurant" class="btn-browse-food">
                    <i class="fa-solid fa-utensils"></i> Explore Restaurants
                </a>
            </div>
        <%
            } else {
        %>
            <!-- Orders Feed -->
            <div class="orders-grid">
                <%
                    for (Orders ord : orderList) {
                        String formattedDate = (ord.getOrderDate() != null) 
                                ? dateFormat.format(ord.getOrderDate()) 
                                : "Recent";
                        
                        String statusClass = "status-placed";
                        String statusIcon = "fa-solid fa-clock";
                        String status = ord.getStatus() != null ? ord.getStatus().toLowerCase() : "placed";

                        if (status.contains("deliver")) {
                            statusClass = "status-delivered";
                            statusIcon = "fa-solid fa-circle-check";
                        } else if (status.contains("cancel")) {
                            statusClass = "status-cancelled";
                            statusIcon = "fa-solid fa-circle-xmark";
                        }
                %>
                    <div class="order-card">
                        
                        <!-- Order Top Header -->
                        <div class="order-card-header">
                            <div class="order-ref">
                                <span class="order-id-label">ORDER #FW-<%= ord.getOrderId() %></span>
                                <span class="order-timestamp"><i class="fa-regular fa-calendar"></i> <%= formattedDate %></span>
                            </div>
                            <span class="status-pill <%= statusClass %>">
                                <i class="<%= statusIcon %>"></i> <%= ord.getStatus() %>
                            </span>
                        </div>

                        <!-- Card Body Summary -->
                        <div class="order-card-body">
                            <div class="order-info-row">
                                <span class="info-label"><i class="fa-solid fa-wallet"></i> Payment</span>
                                <span class="info-value"><%= ord.getPaymentMode() %></span>
                            </div>
                            <div class="order-info-row">
                                <span class="info-label"><i class="fa-solid fa-indian-rupee-sign"></i> Total Paid</span>
                                <span class="info-value highlight-amount">&#8377;<%= String.format("%.2f", ord.getTotalAmount()) %></span>
                            </div>
                        </div>

                        <!-- Card Footer Action -->
                        <div class="order-card-footer">
                            <a href="restaurant" class="btn-reorder">
                                <i class="fa-solid fa-rotate-right"></i> Order Again
                            </a>
                        </div>

                    </div>
                <%
                    }
                %>
            </div>
        <%
            }
        %>

    </main>

    <!-- Footer -->
    <jsp:include page="/includes/footer.jsp" />

</body>
</html>