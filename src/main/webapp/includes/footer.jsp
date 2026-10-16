<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="app-footer">
    <div class="footer-container">
        <!-- Brand & Description -->
        <div class="footer-col brand-col">
            <div class="footer-brand">
                <span class="brand-icon"><i class="fa-solid fa-fire-flame-curved"></i></span>
                Food<span class="brand-accent">Walla</span>
            </div>
            <p class="footer-desc">
                Delivering culinary favorites and regional flavors straight to your doorstep, fresh and fast.
            </p>
            <div class="footer-socials">
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                <a href="#"><i class="fa-brands fa-github"></i></a>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="restaurant"><i class="fa-solid fa-angle-right"></i> All Restaurants</a></li>
                <li><a href="cart"><i class="fa-solid fa-angle-right"></i> View Cart</a></li>
                <li><a href="orders"><i class="fa-solid fa-angle-right"></i> Order History</a></li>
                <li><a href="profile.jsp"><i class="fa-solid fa-angle-right"></i> My Account</a></li>
            </ul>
        </div>

        <!-- Popular Cuisines -->
        <div class="footer-col">
            <h4>Top Cuisines</h4>
            <ul>
                <li><a href="#"><i class="fa-solid fa-angle-right"></i> Dum Biryani</a></li>
                <li><a href="#"><i class="fa-solid fa-angle-right"></i> Artisan Pizza</a></li>
                <li><a href="#"><i class="fa-solid fa-angle-right"></i> North Indian Curries</a></li>
                <li><a href="#"><i class="fa-solid fa-angle-right"></i> Chinese & Momos</a></li>
            </ul>
        </div>

        <!-- Contact & Support -->
        <div class="footer-col">
            <h4>Contact & Help</h4>
            <div class="contact-item">
                <i class="fa-solid fa-location-dot"></i>
                <span>Bangalore, Karnataka, India</span>
            </div>
            <div class="contact-item">
                <i class="fa-solid fa-envelope"></i>
                <span>support@foodwalla.com</span>
            </div>
            <div class="contact-item">
                <i class="fa-solid fa-phone"></i>
                <span>+91 98765 43210</span>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <p>&copy; <%= java.time.Year.now().getValue() %> <strong>FoodWalla</strong>. All rights reserved. Crafted with care.</p>
    </div>
</footer>