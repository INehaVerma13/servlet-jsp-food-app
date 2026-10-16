<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - FoodWalla</title>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- External Modular CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/login.css">
</head>
<body>

	<!-- Ambient Glowing Orbs -->
	<div class="bg-orb bg-orb-1"></div>
	<div class="bg-orb bg-orb-2"></div>

	<!-- Minimal Header Navigation -->
	<header class="auth-nav">
		<a href="restaurant" class="auth-logo"> <i
			class="fa-solid fa-fire-flame-curved"></i> Food<span>Walla</span>
		</a> <a href="restaurant" class="auth-nav-link"> <i
			class="fa-solid fa-arrow-left"></i> Back to Explore
		</a>
	</header>

	<!-- Login Card Container -->
	<div class="auth-wrapper">
		<div class="auth-card">
			<div class="auth-card-head">
				<h2>Welcome Back!</h2>
				<p>Login with your email and password to track orders.</p>
			</div>

			<!-- Dynamic Feedback Alerts from Controller -->
			<%
			String error = (String) request.getAttribute("error");
			String message = (String) request.getAttribute("message");
			if (error != null && !error.trim().isEmpty()) {
			%>
			<div class="auth-alert alert-error">
				<i class="fa-solid fa-circle-exclamation"></i> <span><%=error%></span>
			</div>
			<%
			} else if (message != null && !message.trim().isEmpty()) {
			%>
			<div class="auth-alert alert-success">
				<i class="fa-solid fa-circle-check"></i> <span><%=message%></span>
			</div>
			<%
			}
			%>
			
			
			
			<%
    String logoutParam = request.getParameter("logout");
    if ("true".equals(logoutParam)) {
%>
    <div class="auth-alert alert-success">
        <i class="fa-solid fa-circle-check"></i>
        <span>You have been successfully logged out.</span>
    </div>
<%
    }
%>

			<!-- Login Form (Submits to LoginController via POST) -->
			<form action="login" method="post">
				<input type="hidden" name="action" value="login">

				<div class="form-group">
					<label for="email">Email Address</label>
					<div class="input-wrap">
						<i class="fa-regular fa-envelope"></i> <input type="email"
							id="email" name="email" placeholder="name@example.com" required>
					</div>
				</div>

				<div class="form-group">
					<label for="password">Password</label>
					<div class="input-wrap">
						<i class="fa-solid fa-lock"></i> <input type="password"
							id="password" name="password" placeholder="Enter password"
							required>
					</div>
				</div>

				<button type="submit" class="btn-submit">Login</button>
			</form>

			<!-- Bottom Prompt to Sign Up Controller -->
			<div class="auth-switch-prompt">
				Don't have an account? <a href="signup" class="auth-link-highlight">Sign
					Up</a>
			</div>
		</div>
	</div>

	<footer class="auth-footer">
		&copy;
		<%=java.time.Year.now().getValue()%>
		FoodWalla Inc. All rights reserved.
	</footer>

</body>
</html>