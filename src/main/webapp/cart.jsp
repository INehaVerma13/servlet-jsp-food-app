<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart,com.tap.model.CartItem,com.tap.model.User, java.util.Collection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - FoodWalla</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart.css">
</head>
<body>

    <!-- Ambient Glowing Orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>
    <div class="bg-orb bg-orb-3"></div>

    <!-- Modular Navbar -->
    <jsp:include page="includes/navbar.jsp" />

    <div class="cart-page-wrapper">
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            Collection<CartItem> cartItems = (cart != null) ? cart.getItems() : null;

            if (cartItems != null && !cartItems.isEmpty()) {
                double itemTotal = 0.0;
                for (CartItem ci : cartItems) {
                    itemTotal += (ci.getMenu().getPrice() * ci.getQuantity());
                }
                double deliveryFee = 40.0;
                double platformFee = 10.0;
                double grandTotal = itemTotal + deliveryFee + platformFee;
        %>
            <div class="cart-header-title">
                <span>My Cart (<%= cartItems.size() %> <%= cartItems.size() == 1 ? "item" : "items" %>)</span>
                <!-- Clear Cart Form -->
                <form action="cart" method="post" style="margin: 0;">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn-clear-cart" onclick="return confirm('Are you sure you want to clear your cart?');">
                        <i class="fa-regular fa-trash-can"></i> Clear Cart
                    </button>
                </form>
            </div>

            <div class="cart-layout">
                <!-- Left: Cart Items List -->
                <div class="cart-items-card">
                    <%
                        for (CartItem ci : cartItems) {
                            String itemImg = (ci.getMenu().getImagePath() != null && !ci.getMenu().getImagePath().trim().isEmpty())
                                             ? ci.getMenu().getImagePath()
                                             : "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200";
                            double rowSubtotal = ci.getMenu().getPrice() * ci.getQuantity();
                    %>
                        <div class="cart-item-row">
                            <div class="item-left">
                                <img src="<%= itemImg %>" alt="<%= ci.getMenu().getItemName() %>">
                                <div class="item-meta">
                                    <h4><%= ci.getMenu().getItemName() %></h4>
                                    <span class="item-unit-price">&#8377;<%= String.format("%.2f", ci.getMenu().getPrice()) %> each</span>
                                </div>
                            </div>

                            <!-- Stepper Quantity Controls -->
                            <div class="item-center">
                                <div class="cart-stepper">
                                    <!-- Decrement -->
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="menuId" value="<%= ci.getMenu().getMenuId() %>">
                                        <input type="hidden" name="quantity" value="<%= ci.getQuantity() - 1 %>">
                                        <button type="submit" class="stepper-btn">&#8722;</button>
                                    </form>

                                    <span class="stepper-count"><%= ci.getQuantity() %></span>

                                    <!-- Increment -->
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="menuId" value="<%= ci.getMenu().getMenuId() %>">
                                        <input type="hidden" name="quantity" value="<%= ci.getQuantity() + 1 %>">
                                        <button type="submit" class="stepper-btn">&#43;</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Price & Direct Remove -->
                            <div class="item-right">
                                <div class="item-subtotal">&#8377;<%= String.format("%.2f", rowSubtotal) %></div>
                                
                                <form action="cart" method="post" style="margin: 0;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="menuId" value="<%= ci.getMenu().getMenuId() %>">
                                    <button type="submit" class="btn-item-remove" title="Remove Item">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    <%
                        }
                    %>
                </div>

                <!-- Right: Bill Summary Card -->
                <div class="bill-summary-card">
                    <h3>Bill Details</h3>

                    <div class="bill-row">
                        <span>Item Total</span>
                        <span>&#8377;<%= String.format("%.2f", itemTotal) %></span>
                    </div>
                    <div class="bill-row delivery">
                        <span>Delivery Partner Fee</span>
                        <span>&#8377;<%= String.format("%.2f", deliveryFee) %></span>
                    </div>
                    <div class="bill-row">
                        <span>Platform & Taxes</span>
                        <span>&#8377;<%= String.format("%.2f", platformFee) %></span>
                    </div>

                    <div class="bill-divider"></div>

                    <div class="bill-total">
                        <span>To Pay</span>
                        <span>&#8377;<%= String.format("%.2f", grandTotal) %></span>
                    </div>

                   <%
                        User loggedInUser = (User) session.getAttribute("user");
                        if (loggedInUser != null) {
                    %>
                        <!-- User is logged in: proceed to checkout -->
                        <a href="checkout" class="btn-checkout">
                            Proceed to Checkout <i class="fa-solid fa-arrow-right" style="margin-left: 0.4rem;"></i>
                        </a>
                    <%
                        } else {
                    %>
                        <!-- User is a guest: send to login servlet -->
                        <a href="login" class="btn-checkout" style="background: linear-gradient(135deg, #f97316 0%, #ea580c 100%);">
                            Login to Place Order <i class="fa-solid fa-arrow-right" style="margin-left: 0.4rem;"></i>
                        </a>
                    <%
                        }
                    %>

                    <div class="delivery-badge">
                        <i class="fa-solid fa-shield-halved" style="color: #10b981;"></i> Safe and contactless delivery
                    </div>
                </div>
            </div>
        <%
            } else {
        %>
            <!-- Empty Cart Presentation -->
            <div class="empty-cart-card">
                <div class="empty-cart-icon">
                    <i class="fa-solid fa-bag-shopping"></i>
                </div>
                <h2>Your cart is empty</h2>
                <p>You haven't added any delicious items to your cart yet.</p>
                <a href="restaurant" class="btn-explore">
                    <i class="fa-solid fa-utensils"></i> Browse Restaurants
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