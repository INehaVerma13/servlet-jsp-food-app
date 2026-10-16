<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.tap.model.Cart,com.tap.model.CartItem,com.tap.model.User, java.util.Collection"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout - FoodWalla</title>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- External CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/checkout.css">
</head>
<body>

	<!-- Ambient Glowing Orbs -->
	<div class="bg-orb bg-orb-1"></div>
	<div class="bg-orb bg-orb-2"></div>

	<!-- Reusable Navbar -->
	<jsp:include page="includes/navbar.jsp" />

	<div class="checkout-wrapper">
		<h1 class="checkout-heading">Review &amp; Place Order</h1>

		<%
		Cart cart = (Cart) session.getAttribute("cart");
		User user = (User) session.getAttribute("user");
		Collection<CartItem> cartItems = (cart != null) ? cart.getItems() : null;

		// 1. Guard against empty cart
		if (cartItems == null || cartItems.isEmpty()) {
			response.sendRedirect("cart");
			return;
		}

		// 2. Guard against guest access
		if (user == null) {
			request.setAttribute("error", "Please login to proceed to checkout.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}

		double itemTotal = 0.0;
		for (CartItem ci : cartItems) {
			itemTotal += (ci.getMenu().getPrice() * ci.getQuantity());
		}
		double deliveryFee = 40.0;
		double platformFee = 10.0;
		double grandTotal = itemTotal + deliveryFee + platformFee;

		// Pre-fill user values from session
		String userName = (user.getUserName() != null) ? user.getUserName() : "";
		String userEmail = (user.getEmail() != null) ? user.getEmail() : "";
		String userPhone = (user.getPhone() != null) ? user.getPhone() : "";
		String userAddress = (user.getAddress() != null) ? user.getAddress() : "";
		%>

		<form action="order" method="post">
			<input type="hidden" name="totalAmount" value="<%=grandTotal%>">

			<div class="checkout-grid">
				<!-- Left Column: Form Details -->
				<div>
					<!-- 1. Contact Details -->
					<div class="checkout-card">
						<div class="card-heading">
							<i class="fa-solid fa-user-check"></i> Receiver Contact Details
						</div>

						<div class="form-row">
							<div class="form-group">
								<label for="fullName">Receiver Name</label> <input type="text"
									id="fullName" name="fullName" class="form-control"
									value="<%=userName%>" placeholder="e.g. John Doe" required>
							</div>
							<div class="form-group">
								<label for="phone">10-Digit Mobile Number</label> <input
									type="tel" id="phone" name="phone" class="form-control"
									value="<%=userPhone%>" pattern="[0-9]{10}"
									placeholder="e.g. 9876543210" required>
							</div>
						</div>

						<div class="form-row">
							<div class="form-group">
								<label for="email">Email Receipt Address</label> <input
									type="email" id="email" name="email" class="form-control"
									value="<%=userEmail%>" placeholder="name@example.com"
									required>
							</div>
							<div class="form-group">
								<label for="altPhone">Alternate Mobile (Optional)</label> <input
									type="tel" id="altPhone" name="altPhone" class="form-control"
									pattern="[0-9]{10}" placeholder="Emergency contact">
							</div>
						</div>
					</div>

					<!-- 2. Delivery Address -->
					<div class="checkout-card">
						<div class="card-heading">
							<i class="fa-solid fa-location-dot"></i> Delivery Location
						</div>

						<div class="form-row">
							<div class="form-group">
								<label for="flat">House / Flat / Floor No.</label> <input
									type="text" id="flat" name="flat" class="form-control"
									placeholder="Flat 402, 4th Floor" required>
							</div>
							<div class="form-group">
								<label for="building">Building / Apartment Name</label> <input
									type="text" id="building" name="building" class="form-control"
									placeholder="e.g. Prestige Greenwoods" required>
							</div>
						</div>

						<div class="form-group">
							<label for="address">Street / Area / Locality</label> <input
								type="text" id="address" name="address" class="form-control"
								value="<%=userAddress%>"
								placeholder="e.g. 100ft Road, Indiranagar" required>
						</div>

						<div class="form-row">
							<div class="form-group">
								<label for="landmark">Nearby Landmark (Optional)</label> <input
									type="text" id="landmark" name="landmark" class="form-control"
									placeholder="e.g. Opposite Metro Station / Near Apollo">
							</div>
							<div class="form-group">
								<label for="pincode">PIN Code</label> <input type="text"
									id="pincode" name="pincode" class="form-control"
									pattern="[0-9]{6}" placeholder="e.g. 560038" required>
							</div>
						</div>

						<div class="form-group">
							<label>Save Address As</label>
							<div class="tag-pills">
								<label class="tag-pill"> <input type="radio"
									name="addressType" value="Home" checked> <i
									class="fa-solid fa-house"></i> Home
								</label> <label class="tag-pill"> <input type="radio"
									name="addressType" value="Work"> <i
									class="fa-solid fa-briefcase"></i> Work
								</label> <label class="tag-pill"> <input type="radio"
									name="addressType" value="Other"> <i
									class="fa-solid fa-location-dot"></i> Other
								</label>
							</div>
						</div>
					</div>

					<!-- 3. Instructions & Notes -->
					<div class="checkout-card">
						<div class="card-heading">
							<i class="fa-solid fa-person-biking"></i> Delivery &amp; Cooking
							Instructions
						</div>

						<div class="instruction-chips">
							<label class="instruction-chip"> <input type="checkbox"
								name="instructions" value="leave_at_door"> <i
								class="fa-solid fa-door-open"></i> <span>Leave at Door</span>
							</label> <label class="instruction-chip"> <input type="checkbox"
								name="instructions" value="dont_ring_bell"> <i
								class="fa-regular fa-bell-slash"></i> <span>Don't Ring
									Bell</span>
							</label> <label class="instruction-chip"> <input type="checkbox"
								name="instructions" value="avoid_calling"> <i
								class="fa-solid fa-phone-slash"></i> <span>Avoid Calling</span>
							</label> <label class="instruction-chip"> <input type="checkbox"
								name="instructions" value="leave_with_guard"> <i
								class="fa-solid fa-shield-halved"></i> <span>Leave with
									Guard</span>
							</label>
						</div>

						<div class="form-group" style="margin-top: 1rem;">
							<label for="cookingNotes">Notes for the Chef / Restaurant</label>
							<input type="text" id="cookingNotes" name="cookingNotes"
								class="form-control"
								placeholder="e.g. Less spicy, extra tissues, separate gravy...">
						</div>
					</div>

					<!-- 4. Payment Method -->
					<div class="checkout-card">
						<div class="card-heading">
							<i class="fa-solid fa-credit-card"></i> Payment Method
						</div>

						<div class="payment-options">

							<!-- UPI Option -->
							<div class="payment-option-block">
								<label class="payment-radio-label"> <input type="radio"
									name="paymentMode" value="UPI" checked> <i
									class="fa-solid fa-qrcode payment-icon"></i>
									<div>
										<div style="font-weight: 700;">UPI Instant Pay</div>
										<small style="color: var(--slate);">Google Pay,
											PhonePe, Paytm, BHIM</small>
									</div>
								</label>
								<!-- Collapsible UPI input -->
								<div class="payment-subform">
									<div class="form-group" style="margin-bottom: 0;">
										<label for="upiId">Enter UPI ID / VPA</label> <input
											type="text" id="upiId" name="upiId" class="form-control"
											placeholder="username@okhdfcbank / mobile@paytm">
									</div>
								</div>
							</div>

							<!-- Card Option -->
							<div class="payment-option-block">
								<label class="payment-radio-label"> <input type="radio"
									name="paymentMode" value="Card"> <i
									class="fa-regular fa-credit-card payment-icon"></i>
									<div>
										<div style="font-weight: 700;">Credit / Debit Card</div>
										<small style="color: var(--slate);">Visa, Mastercard,
											RuPay</small>
									</div>
								</label>
								<!-- Collapsible Card Inputs -->
								<div class="payment-subform">
									<div class="form-group">
										<label for="cardNumber">Card Number</label> <input type="text"
											id="cardNumber" name="cardNumber" class="form-control"
											maxlength="19" placeholder="1234 5678 9012 3456">
									</div>
									<div class="form-row">
										<div class="form-group" style="margin-bottom: 0;">
											<label for="cardExpiry">Valid Thru (MM/YY)</label> <input
												type="text" id="cardExpiry" name="cardExpiry"
												class="form-control" maxlength="5" placeholder="MM/YY">
										</div>
										<div class="form-group" style="margin-bottom: 0;">
											<label for="cardCvv">CVV</label> <input type="password"
												id="cardCvv" name="cardCvv" class="form-control"
												maxlength="3" placeholder="123">
										</div>
									</div>
								</div>
							</div>

							<!-- Cash on Delivery Option -->
							<div class="payment-option-block">
								<label class="payment-radio-label"> <input type="radio"
									name="paymentMode" value="COD"> <i
									class="fa-solid fa-money-bill-wave payment-icon"></i>
									<div>
										<div style="font-weight: 700;">Cash on Delivery</div>
										<small style="color: var(--slate);">Pay via cash or
											UPI scan upon arrival</small>
									</div>
								</label>
							</div>

						</div>
					</div>
				</div>

				<!-- Right Column: Summary Box -->
				<div>
					<div class="order-summary-box">
						<div class="card-heading">
							<i class="fa-solid fa-receipt"></i> Order Summary
						</div>

						<div style="margin-bottom: 1.2rem;">
							<%
							for (CartItem ci : cartItems) {
							%>
							<div class="summary-item-row">
								<span class="summary-item-name"><%=ci.getQuantity()%>
									&times; <%=ci.getMenu().getItemName()%></span> <span>&#8377;<%=String.format("%.2f", ci.getMenu().getPrice() * ci.getQuantity())%></span>
							</div>
							<%
							}
							%>
						</div>

						<div class="calc-divider"></div>

						<div class="calc-row">
							<span>Item Total</span> <span>&#8377;<%=String.format("%.2f", itemTotal)%></span>
						</div>
						<div class="calc-row highlight">
							<span>Delivery Partner Fee</span> <span>&#8377;<%=String.format("%.2f", deliveryFee)%></span>
						</div>
						<div class="calc-row">
							<span>Platform Fee &amp; Taxes</span> <span>&#8377;<%=String.format("%.2f", platformFee)%></span>
						</div>

						<div class="calc-divider"></div>

						<div class="grand-total-row">
							<span>To Pay</span> <span>&#8377;<%=String.format("%.2f", grandTotal)%></span>
						</div>

						<button type="submit" class="btn-place-order">
							Confirm &amp; Place Order <i class="fa-solid fa-arrow-right"
								style="margin-left: 0.35rem;"></i>
						</button>

						<div class="policy-card">
							<strong style="color: var(--dark);">100% On-time
								guarantee:</strong> Backed by full customer refund protection in case of
							delays.
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- Reusable Universal Footer -->
	<jsp:include page="includes/footer.jsp" />

</body>
</html>