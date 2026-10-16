<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List,com.tap.model.Menu,com.tap.model.Restaurant,com.tap.model.Cart,com.tap.model.CartItem"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Menu - FoodWalla</title>

<!-- Fonts & Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/menu.css?v=foodwalla_v4">
</head>
<body class="menu-body">

	<!-- Navbar with Soft Ambient Shadow -->
	<div class="swiggy-nav-wrap">
		<jsp:include page="includes/navbar.jsp" />
	</div>

	<%
	Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
	List<Menu> menuList = (List<Menu>) request.getAttribute("allMenu");
	String restName = (restaurant != null) ? restaurant.getName() : "Haldiram's Restaurant";
	String restAddress = (restaurant != null) ? restaurant.getAddress() : "BTM Layout, Bangalore";
	String cuisine = (restaurant != null) ? restaurant.getCuisineType() : "North Indian, Chaat";
	double rating = (restaurant != null) ? restaurant.getRating() : 4.0;
	int deliveryTime = (restaurant != null) ? restaurant.getDeliveryTime() : 30;
	String restBannerImg = (restaurant != null && restaurant.getImagePath() != null
			&& !restaurant.getImagePath().trim().isEmpty())
			? restaurant.getImagePath()
			: "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=1000";
	%>

	<!-- Floating Sticky MENU Pill pinned to bottom-right of content -->
	<button type="button" class="floating-menu-widget"
		onclick="window.scrollTo({top: 600, behavior: 'smooth'})">
		<span class="widget-title">MENU</span> <i class="fa-solid fa-utensils"></i>
	</button>

	<main class="menu-main-container">
		<!-- Breadcrumbs -->
		<nav class="page-breadcrumbs">
			<a href="restaurant">Home</a> <span>/</span> <a href="restaurant">Bangalore</a>
			<span>/</span> <span class="active-crumb"><%=restName%></span>
		</nav>

		<!-- Restaurant Heading -->
		<h1 class="rest-heading"><%=restName%></h1>

		<!-- Service Tabs (No full-width border line, orange sits right above image) -->
		<div class="service-tabs">
			<button type="button" class="service-tab active">Order
				Online</button>
			<button type="button" class="service-tab">Dineout</button>
		</div>

		<!-- Large Hero Banner Image -->
		<div class="restaurant-hero-banner">
			<img src="<%=restBannerImg%>" alt="<%=restName%>">
		</div>

		<!-- Restaurant Metadata Card -->
		<div class="restaurant-meta-card">
			<div class="meta-row">
				<span class="meta-rating-pill"> <i
					class="fa-solid fa-circle-star"></i> <%=String.format("%.1f", rating)%>
					(1.4K+ ratings)
				</span> <span class="meta-dot">&bull;</span> <span class="meta-cost">&#8377;300
					for two</span>
			</div>
			<div class="cuisine-tag"><%=cuisine%></div>
			<div class="timing-row">
				<span class="open-status">Open now</span> <span class="timing-text">&bull;
					Closes 11:00 pm &#9662;</span>
			</div>

			<!-- Delivery Tracker (No separator line above) -->
			<div class="delivery-tracker">
				<div class="tracker-bullet-col">
					<span class="tracker-circle"></span> <span class="tracker-line"></span>
					<span class="tracker-circle"></span>
				</div>
				<div class="tracker-text-col">
					<div class="tracker-row">
						<strong>Outlet</strong> <span><%=restAddress%> &#9662;</span>
					</div>
					<div class="tracker-row">
						<strong><%=deliveryTime%>-<%=deliveryTime + 10%> mins</strong>
					</div>
				</div>
			</div>
		</div>

		<!-- Centered Gray Search Bar -->
		<div class="menu-search-wrapper" id="dish-list-section">
			<div class="search-input-box">
				<input type="text" id="dishSearchInput"
					placeholder="Search for dishes" onkeyup="filterDishes()"> <i
					class="fa-solid fa-magnifying-glass search-icon"></i>
			</div>
		</div>

		<!-- Filter Toggle Bar -->
		<div class="menu-filter-bar">
			<button type="button" class="pill-toggle veg-pill" id="vegFilterBtn"
				onclick="toggleDiet('veg')">
				<span class="food-badge veg"><span class="badge-dot"></span></span>
				<span class="toggle-switch"></span>
			</button>

			<button type="button" class="pill-toggle nonveg-pill"
				id="nonVegFilterBtn" onclick="toggleDiet('non-veg')">
				<span class="food-badge non-veg"><span class="badge-dot"></span></span>
				<span class="toggle-switch"></span>
			</button>

			<button type="button" class="text-pill" id="bestsellerBtn"
				onclick="toggleBestseller()">Bestseller</button>
		</div>

		<!-- Category Title (Borderless stream on white background) -->
		<div class="menu-category-stream">
			<div class="category-header">
				<h2><%=(cuisine.contains(",")) ? cuisine.split(",")[0].trim() : cuisine%>
					(<%=(menuList != null) ? menuList.size() : 0%>)
				</h2>
				<i class="fa-solid fa-chevron-up"></i>
			</div>

			<!-- Dish Items Stream -->
			<div class="dishes-stream" id="dishesStream">
				<%
				if (menuList != null && !menuList.isEmpty()) {
					int count = 0;
					Cart sessionCart = (Cart) session.getAttribute("cart");

					for (Menu m : menuList) {
						count++;
						String imagePath = (m.getImagePath() != null && !m.getImagePath().trim().isEmpty())
						? m.getImagePath()
						: "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400";

						int itemQty = 0;
						if (sessionCart != null && sessionCart.getItems() != null) {
					for (CartItem ci : sessionCart.getItems()) {
						if (ci.getMenu() != null && ci.getMenu().getMenuId() == m.getMenuId()) {
							itemQty = ci.getQuantity();
							break;
						}
					}
						}

						boolean isBestseller = (count % 2 != 0);
				%>

				<div class="dish-item-row <%=(count > 5) ? "hidden-item" : ""%>"
					data-veg="<%=m.isVeg() ? "true" : "false"%>"
					data-name="<%=m.getItemName().toLowerCase()%>"
					data-bestseller="<%=isBestseller ? "true" : "false"%>">

					<!-- Left Side: Dish Info -->
					<div class="dish-info-col">
						<div class="dish-badge-row">
							<%
							if (m.isVeg()) {
							%>
							<span class="food-badge veg" title="Pure Veg"><span
								class="badge-dot"></span></span>
							<%
							} else {
							%>
							<span class="food-badge non-veg" title="Non-Veg"><span
								class="badge-dot"></span></span>
							<%
							}
							%>
							<%
							if (isBestseller) {
							%>
							<span class="bestseller-star-label"><i
								class="fa-solid fa-star"></i> Bestseller</span>
							<%
							}
							%>
						</div>

						<h3 class="dish-title-text"><%=m.getItemName()%></h3>
						<div class="dish-price-text">
							&#8377;<%=String.format("%.0f", m.getPrice())%></div>

						<div class="dish-rating-label">
							<i class="fa-solid fa-star"></i> 4.<%=(count % 3) + 1%>
							(<%=(count * 14) + 3%>)
						</div>

						<p class="dish-description-text"><%=(m.getDescription() != null)
		? m.getDescription()
		: "Freshly prepared with authentic ingredients and traditional spices."%></p>
					</div>

					<!-- Right Side: Dish Image & ADD Button -->
					<div class="dish-action-col">
						<div class="dish-photo-box">
							<img src="<%=imagePath%>" alt="<%=m.getItemName()%>"
								loading="lazy">

							<%
							if (!m.isAvailable()) {
							%>
							<span class="sold-out-pill">Sold Out</span>
							<%
							} else if (itemQty == 0) {
							%>
							<form action="cart" method="post" class="add-form">
								<input type="hidden" name="action" value="add"> <input
									type="hidden" name="menuId" value="<%=m.getMenuId()%>">
								<button type="submit" class="btn-dish-add">ADD</button>
							</form>
							<%
							} else {
							%>
							<div class="dish-counter-box">
								<form action="cart" method="post"
									style="display: inline; margin: 0;">
									<input type="hidden" name="action" value="update"> <input
										type="hidden" name="menuId" value="<%=m.getMenuId()%>">
									<input type="hidden" name="quantity" value="<%=itemQty - 1%>">
									<input type="hidden" name="source" value="menu">
									<button type="submit" class="counter-btn">&#8722;</button>
								</form>
								<span class="counter-val"><%=itemQty%></span>
								<form action="cart" method="post"
									style="display: inline; margin: 0;">
									<input type="hidden" name="action" value="update"> <input
										type="hidden" name="menuId" value="<%=m.getMenuId()%>">
									<input type="hidden" name="quantity" value="<%=itemQty + 1%>">
									<input type="hidden" name="source" value="menu">
									<button type="submit" class="counter-btn">&#43;</button>
								</form>
							</div>
							<%
							}
							%>
						</div>
						<div class="customisable-subtext">Customisable</div>
					</div>
				</div>

				<%
				}
				}
				%>
			</div>

			<!-- "View full menu ⌄" Text Link directly under dishes -->
			<div class="view-menu-wrapper" id="viewAllBox">
				<button type="button" class="view-menu-link"
					onclick="showAllItems()">
					View full menu <i class="fa-solid fa-angle-down"></i>
				</button>
			</div>
		</div>

		<!-- Related Restaurants Horizontal Interactive Carousel -->
		<section class="related-rest-section">
			<h3>
				Related to
				<%=restName%></h3>
			<div class="related-carousel">
				<a href="restaurant" class="related-card"> <img
					src="https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=300"
					alt="Al Zara Mandi">
					<h4>Al Zara Mandi...</h4>
					<p>
						<i class="fa-solid fa-star"></i> 4.1 &bull; 20-25 mins
					</p> <span>Cafe &bull; BTM</span>
				</a> <a href="restaurant" class="related-card"> <img
					src="https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=300"
					alt="Taste of Punjab">
					<h4>Taste of Punjab</h4>
					<p>
						<i class="fa-solid fa-star"></i> 4.2 &bull; 15-20 mins
					</p> <span>North Indian &bull; BTM</span>
				</a> <a href="restaurant" class="related-card"> <img
					src="https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=300"
					alt="Paakashala">
					<h4>Paakashala</h4>
					<p>
						<i class="fa-solid fa-star"></i> 4.3 &bull; 20-25 mins
					</p> <span>South Indian &bull; Arekere</span>
				</a> <a href="restaurant" class="related-card"> <img
					src="https://images.unsplash.com/photo-1540420773420-3366772f4999?w=300"
					alt="Shero Home Food">
					<h4>Shero Home Food</h4>
					<p>
						<i class="fa-solid fa-star"></i> 4.6 &bull; 40-45 mins
					</p> <span>Home Food &bull; BTM</span>
				</a>
			</div>
		</section>

		<!-- About Restaurant Description Block -->
		<section class="about-outlet-block">
			<h3>
				About
				<%=restName%></h3>
			<div class="about-card-box">
				<h4>
					Best-Selling Dishes at
					<%=restName%></h4>
				<p><%=restName%>
					is a popular food destination in
					<%=restAddress%>, known for serving delicious authentic meals.
					Customers can order from
					<%=restName%>
					for fresh preparation, satisfying portions, and flavorful dishes.
				</p>
				<h4>Rajma Chawal</h4>
				<p>
					Rajma Chawal is one of the popular dishes at
					<%=restName%>. It is prepared with quality ingredients and offers a
					delightful rich flavor.
				</p>
				<button type="button" class="see-more-link">See more
					&#9662;</button>
			</div>
		</section>

		<!-- FAQs Section -->
		<section class="faq-section">
			<h3>
				FAQs about
				<%=restName%></h3>
			<div class="faq-item" onclick="toggleFaq(this)">
				<div class="faq-question">
					<span>Does <%=restName%> deliver food in Bangalore on
						FoodWalla?
					</span> <i class="fa-solid fa-chevron-down faq-arrow"></i>
				</div>
				<div class="faq-answer">
					<p>
						Yes,
						<%=restName%>
						delivers food in Bangalore through FoodWalla. Customers can order
						their favorite dishes online and enjoy quick doorstep delivery.
					</p>
				</div>
			</div>

			<div class="faq-item" onclick="toggleFaq(this)">
				<div class="faq-question">
					<span>What is <%=restName%> known for?
					</span> <i class="fa-solid fa-chevron-down faq-arrow"></i>
				</div>
				<div class="faq-answer">
					<p><%=restName%>
						is famous for authentic flavors, fast delivery, quality packaging,
						and delicious fresh recipes.
					</p>
				</div>
			</div>

			<div class="faq-item" onclick="toggleFaq(this)">
				<div class="faq-question">
					<span>What are the most popular dishes at <%=restName%>?
					</span> <i class="fa-solid fa-chevron-down faq-arrow"></i>
				</div>
				<div class="faq-answer">
					<p>Popular choices include Thalis, signature curries,
						traditional breads, and chef-special combos.</p>
				</div>
			</div>
		</section>

		<!-- Regulatory Disclaimer & FSSAI License -->
		<section class="disclaimer-section">
			<h4>Disclaimer</h4>
			<ul>
				<li>All prices are set directly by the restaurant.</li>
				<li>All nutritional information is indicative; values are per
					serve as shared by the restaurant and may vary depending on the
					ingredients and portion size.</li>
				<li>An average active adult requires 2,000 kcal energy per day,
					however calorie needs may vary.</li>
			</ul>
			<div class="fssai-row">
				<span class="fssai-logo">fssai</span> <span class="fssai-num">License
					No. 21226181000417</span>
			</div>
			<div class="outlet-legal-info">
				<strong><%=restName%></strong>
				<p><%=restAddress%></p>
			</div>
		</section>
	</main>

	<!-- Footer -->
	<footer class="foodwalla-footer">
		<div class="footer-inner">
			<div class="footer-brand-col">
				<div class="footer-logo">Food Walla</div>
				<p>&copy; 2026 FoodWalla Limited</p>
			</div>
			<div class="footer-links-col">
				<h5>Company</h5>
				<a href="#">About Us</a> <a href="#">Careers</a> <a href="#">Team</a>
			</div>
			<div class="footer-links-col">
				<h5>Contact us</h5>
				<a href="#">Help & Support</a> <a href="#">Partner with us</a> <a
					href="#">Ride with us</a>
			</div>
			<div class="footer-links-col">
				<h5>Legal</h5>
				<a href="#">Terms & Conditions</a> <a href="#">Cookie Policy</a> <a
					href="#">Privacy Policy</a>
			</div>
			<div class="footer-links-col">
				<h5>We deliver to:</h5>
				<a href="#">Bangalore</a> <a href="#">Gurgaon</a> <a href="#">Hyderabad</a>
				<a href="#">Delhi</a> <a href="#">Mumbai</a> <a href="#">Pune</a>
			</div>
		</div>
	</footer>

	<!-- Scripts -->
	<script>
		let isVegActive = false;
		let isNonVegActive = false;
		let isBestsellerActive = false;

		function toggleDiet(type) {
			if (type === 'veg') {
				isVegActive = !isVegActive;
				document.getElementById('vegFilterBtn').classList.toggle('active', isVegActive);
				if (isVegActive && isNonVegActive) {
					isNonVegActive = false;
					document.getElementById('nonVegFilterBtn').classList.remove('active');
				}
			} else {
				isNonVegActive = !isNonVegActive;
				document.getElementById('nonVegFilterBtn').classList.toggle('active', isNonVegActive);
				if (isNonVegActive && isVegActive) {
					isVegActive = false;
					document.getElementById('vegFilterBtn').classList.remove('active');
				}
			}
			applyFilters();
		}

		function toggleBestseller() {
			isBestsellerActive = !isBestsellerActive;
			document.getElementById('bestsellerBtn').classList.toggle('active', isBestsellerActive);
			applyFilters();
		}

		function filterDishes() {
			applyFilters();
		}

		function applyFilters() {
			const query = document.getElementById('dishSearchInput').value.toLowerCase().trim();
			const items = document.querySelectorAll('.dish-item-row');

			items.forEach(item => {
				const isVeg = item.getAttribute('data-veg') === 'true';
				const name = item.getAttribute('data-name');
				const isBest = item.getAttribute('data-bestseller') === 'true';

				let matchesDiet = true;
				if (isVegActive) matchesDiet = (isVeg === true);
				if (isNonVegActive) matchesDiet = (isVeg === false);

				let matchesBest = true;
				if (isBestsellerActive) matchesBest = (isBest === true);

				let matchesQuery = name.includes(query);

				if (matchesDiet && matchesBest && matchesQuery) {
					item.style.display = 'flex';
				} else {
					item.style.display = 'none';
				}
			});
		}

		function showAllItems() {
			document.querySelectorAll('.dish-item-row.hidden-item').forEach(el => {
				el.classList.remove('hidden-item');
			});
			const btnBox = document.getElementById('viewAllBox');
			if (btnBox) btnBox.style.display = 'none';
		}

		function toggleFaq(element) {
			element.classList.toggle('open');
		}
	</script>








	<!-- Different Restaurant Conflict Modal -->
	<%
	String cartError = request.getParameter("cartError");
	String pendingMenuId = request.getParameter("pendingMenuId");
	if ("differentRestaurant".equals(cartError) && pendingMenuId != null) {
	%>
	<div class="swiggy-modal-overlay" id="conflictModal">
		<div class="swiggy-modal-card">
			<h3 class="modal-title">Items already in cart</h3>
			<p class="modal-desc">Your cart contains items from other
				restaurant. Would you like to reset your cart for adding items from
				this restaurant?</p>
			<div class="modal-btn-row">
				<!-- NO Button -->
				<button type="button" class="btn-modal-no"
					onclick="closeConflictModal()">NO</button>

				<!-- YES, START AFRESH Button -->
				<form action="cart" method="post" style="margin: 0; flex: 1;">
					<input type="hidden" name="action" value="resetAndAdd"> <input
						type="hidden" name="menuId" value="<%=pendingMenuId%>">
					<button type="submit" class="btn-modal-yes">YES, START
						AFRESH</button>
				</form>
			</div>
		</div>
	</div>

	<script>
		function closeConflictModal() {
			const modal = document.getElementById('conflictModal');
			if (modal) modal.style.display = 'none';
			// Clean URL without reloading
			const url = new URL(window.location.href);
			url.searchParams.delete('cartError');
			url.searchParams.delete('pendingMenuId');
			window.history.replaceState({}, document.title, url.toString());
		}
	</script>
	<%
	}
	%>

</body>
</html>