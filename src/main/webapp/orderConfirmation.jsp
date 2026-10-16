<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Orders"%>
<%@ page import="com.tap.model.User"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Orders order = (Orders) session.getAttribute("latestOrder");
    if (order == null) {
        response.sendRedirect("restaurant");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed | FoodWalla</title>
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <!-- Master & Page Styles -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/orderConfirmation.css">
    
    <!-- Canvas-Confetti library (Lightweight, single CDN, auto-triggers confetti bursts) -->
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.2/dist/confetti.browser.min.js"></script>
</head>
<body>

    <!-- Ambient Glow Orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>

    <!-- Navigation Header -->
    <jsp:include page="/includes/navbar.jsp" />

    <main class="confirm-wrapper">
        <div class="confirm-card">
            
            <!-- Success Badge -->
            <div class="celebration-badge">
                <i class="fa-solid fa-circle-check"></i>
                <span>Order Placed!</span>
            </div>

            <h1 class="confirm-title">Woohoo! Food is on the way!</h1>
            <p class="confirm-subtitle">
                Hang tight, <strong><%= user.getUserName() != null ? user.getUserName() : "Foodie" %></strong>. The kitchen has received your ticket and the chef is firing up the stove.
            </p>

            <!-- ================= Animated Delivery Scene ================= -->
            <div class="delivery-stage">
                <!-- Skyline / Cloud backdrop -->
                <div class="sky-elements">
                    <span class="cloud cloud-1"><i class="fa-solid fa-cloud"></i></span>
                    <span class="cloud cloud-2"><i class="fa-solid fa-cloud"></i></span>
                </div>

                <!-- Scooter Rider -->
                <div class="vehicle-runner">
                    <div class="scooter-body">
                        <i class="fa-solid fa-motorcycle"></i>
                        <span class="food-bag"><i class="fa-solid fa-box"></i></span>
                    </div>
                    <div class="speed-lines"></div>
                </div>

                <!-- Animated Moving Road -->
                <div class="road-track">
                    <div class="road-dashes"></div>
                </div>
            </div>

            <!-- Estimated Delivery Banner -->
            <div class="delivery-eta-banner">
                <div class="eta-left">
                    <i class="fa-solid fa-stopwatch"></i>
                    <div>
                        <div class="eta-label">ESTIMATED TIME</div>
                        <div class="eta-time">30 - 40 Mins</div>
                    </div>
                </div>
                <div class="eta-live-tag">
                    <span class="pulse-dot"></span> In Kitchen
                </div>
            </div>

            <!-- ================= Progress Step Tracker ================= -->
            <div class="order-stepper">
                <div class="step-node active">
                    <div class="step-circle"><i class="fa-solid fa-receipt"></i></div>
                    <div class="step-text">Placed</div>
                </div>
                <div class="step-line active"></div>

                <div class="step-node active">
                    <div class="step-circle"><i class="fa-solid fa-fire-burner"></i></div>
                    <div class="step-text">Cooking</div>
                </div>
                <div class="step-line"></div>

                <div class="step-node">
                    <div class="step-circle"><i class="fa-solid fa-person-biking"></i></div>
                    <div class="step-text">On Route</div>
                </div>
                <div class="step-line"></div>

                <div class="step-node">
                    <div class="step-circle"><i class="fa-solid fa-house-chimney"></i></div>
                    <div class="step-text">Delivered</div>
                </div>
            </div>

            <!-- Order Details Grid -->
            <div class="order-meta-box">
                <div class="meta-item">
                    <span class="meta-label">ORDER ID</span>
                    <span class="meta-value">#FW-<%= order.getOrderId() %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">PAYMENT MODE</span>
                    <span class="meta-value"><%= order.getPaymentMode() %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">ORDER STATUS</span>
                    <span class="meta-value status-badge"><%= order.getStatus() %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">TOTAL PAID</span>
                    <span class="meta-value highlight-price">&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></span>
                </div>
            </div>

            <!-- Actions -->
            <div class="confirm-actions">
                <a href="orders" class="btn-primary-action">
                    <i class="fa-solid fa-clock-rotate-left"></i> View All Orders
                </a>
                <a href="restaurant" class="btn-secondary-action">
                    <i class="fa-solid fa-utensils"></i> Order More Food
                </a>
            </div>

        </div>
    </main>

    <!-- Master Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Script to Trigger Confetti on Load -->
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            // Confetti Blast 1 (Center Pop)
            confetti({
                particleCount: 120,
                spread: 80,
                origin: { y: 0.55 },
                colors: ['#ff6026', '#10b981', '#3b82f6', '#f59e0b', '#ec4899']
            });

            // Confetti Cannon from Left Corner
            setTimeout(() => {
                confetti({
                    particleCount: 70,
                    angle: 60,
                    spread: 65,
                    origin: { x: 0, y: 0.7 },
                    colors: ['#ff6026', '#fbbf24', '#34d399']
                });
            }, 300);

            // Confetti Cannon from Right Corner
            setTimeout(() => {
                confetti({
                    particleCount: 70,
                    angle: 120,
                    spread: 65,
                    origin: { x: 1, y: 0.7 },
                    colors: ['#ff6026', '#60a5fa', '#a78bfa']
                });
            }, 500);
        });
    </script>
</body>
</html>