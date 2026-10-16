<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.tap.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodWalla - Order Food Online</title>
    
    <!-- External CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/restaurant.css">
</head>
<body>

    <!-- Ambient Glowing Orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>
    <div class="bg-orb bg-orb-3"></div>

    <!-- Reusable Navbar Included Here -->
    <jsp:include page="includes/navbar.jsp" />

    <div class="page-wrapper">
        <!-- Hero Section -->
        <section class="hero-block">
            <h1>Cravings delivered <span>fast & fresh</span></h1>
            <p>Order from top regional culinary gems across India</p>

            <div class="search-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="searchInput" placeholder="Search by restaurant name, cuisine, or area..." onkeyup="handleSearch()">
            </div>
        </section>

        <!-- Category Carousel -->
        <section class="category-block">
            <div class="section-head">
                <h2>What's on your mind?</h2>
                <span id="clearBtn" style="font-size: 0.85rem; color: var(--primary); cursor: pointer; display: none;" onclick="clearCuisine()">Clear Filter ✕</span>
            </div>

            <div class="category-row">
                <div class="cat-pill" onclick="filterCuisine('Biryani', this)">
                    <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200" alt="Biryani">
                    <span>Biryani</span>
                </div>
                <div class="cat-pill" onclick="filterCuisine('Pizza', this)">
                    <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200" alt="Pizza">
                    <span>Pizza</span>
                </div>
                <div class="cat-pill" onclick="filterCuisine('Burger', this)">
                    <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200" alt="Burger">
                    <span>Burgers</span>
                </div>
                <div class="cat-pill" onclick="filterCuisine('North Indian', this)">
                    <img src="https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=200" alt="North Indian">
                    <span>North Indian</span>
                </div>
                <div class="cat-pill" onclick="filterCuisine('Chinese', this)">
                    <img src="https://images.unsplash.com/photo-1525755662778-989d0524087e?w=200" alt="Chinese">
                    <span>Chinese</span>
                </div>
                <div class="cat-pill" onclick="filterCuisine('Dessert', this)">
                    <img src="https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=200" alt="Dessert">
                    <span>Desserts</span>
                </div>
            </div>
        </section>

        <!-- Restaurant Cards Grid -->
        <section>
            <div class="section-head">
                <h2>Popular Restaurants</h2>
            </div>

            <div class="restaurant-grid" id="restaurantsContainer">
                <%
                    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
                    if (restaurants != null && !restaurants.isEmpty()) {
                        for (Restaurant r : restaurants) {
                            String imagePath = (r.getImagePath() != null && !r.getImagePath().trim().isEmpty()) 
                                               ? r.getImagePath() 
                                               : "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600";
                %>
                            <a href="menu?restaurantId=<%= r.getRestaurantId() %>" 
                               class="card-restaurant" 
                               data-name="<%= r.getName().toLowerCase() %>" 
                               data-cuisine="<%= r.getCuisineType().toLowerCase() %>"
                               data-address="<%= (r.getAddress() != null) ? r.getAddress().toLowerCase() : "" %>">
                                
                                <div class="card-thumb">
                                    <img src="<%= imagePath %>" alt="<%= r.getName() %>" loading="lazy">
                                    <span class="status-badge <%= r.isActive() ? "badge-open" : "badge-closed" %>">
                                        <%= r.isActive() ? "Open" : "Closed" %>
                                    </span>
                                </div>

                                <div class="card-details">
                                    <div class="name-rating-row">
                                        <h3><%= r.getName() %></h3>
                                        <span class="rating-badge">&#9733; <%= r.getRating() %></span>
                                    </div>
                                    <p class="cuisine-txt"><%= r.getCuisineType() %></p>
                                    <p class="address-txt"><%= r.getAddress() %></p>
                                    
                                    <div class="card-meta-footer">
                                        <span class="time-info">
                                            <i class="fa-regular fa-clock"></i> <%= r.getDeliveryTime() %> mins
                                        </span>
                                        <span class="view-action">
                                            View Menu <i class="fa-solid fa-chevron-right" style="font-size: 0.75rem;"></i>
                                        </span>
                                    </div>
                                </div>
                            </a>
                <%
                        }
                    } else {
                %>
                        <div class="empty-alert">
                            <i class="fa-solid fa-utensils" style="font-size: 3rem; color: #cbd5e1; margin-bottom: 1rem;"></i>
                            <h3>No restaurants available right now.</h3>
                            <p>Please check database records or servlet controller mapping.</p>
                        </div>
                <%
                    }
                %>
            </div>
        </section>
    </div>
    
    <!-- PUT FOOTER RIGHT HERE -->
    <jsp:include page="includes/footer.jsp" />

    <!-- Live Filter JS -->
    <script>
    let currentCuisine = '';

    function handleSearch() {
        const query = document.getElementById('searchInput').value.toLowerCase().trim();
        applyFilter(query, currentCuisine);
    }

    function filterCuisine(cuisine, el) {
        if (currentCuisine === cuisine.toLowerCase()) {
            clearCuisine();
            return;
        }
        document.querySelectorAll('.cat-pill').forEach(c => c.classList.remove('active'));
        el.classList.add('active');
        currentCuisine = cuisine.toLowerCase();

        const clearBtn = document.getElementById('clearBtn');
        clearBtn.style.display = 'inline';
        clearBtn.innerText = 'Clear Filter (' + cuisine + ') ✕';

        const query = document.getElementById('searchInput').value.toLowerCase().trim();
        applyFilter(query, currentCuisine);
    }

    function clearCuisine() {
        currentCuisine = '';
        document.querySelectorAll('.cat-pill').forEach(c => c.classList.remove('active'));
        document.getElementById('clearBtn').style.display = 'none';

        const query = document.getElementById('searchInput').value.toLowerCase().trim();
        applyFilter(query, '');
    }

    function applyFilter(query, cuisine) {
        document.querySelectorAll('.card-restaurant').forEach(card => {
            const name = card.getAttribute('data-name') || '';
            const cardCuisine = card.getAttribute('data-cuisine') || '';
            const address = card.getAttribute('data-address') || '';

            const matchesQuery = !query || name.includes(query) || cardCuisine.includes(query) || address.includes(query);
            const matchesCuisine = !cuisine || cardCuisine.includes(cuisine);

            card.style.display = (matchesQuery && matchesCuisine) ? 'flex' : 'none';
        });
    }
    </script>
</body>
</html>