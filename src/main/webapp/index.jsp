<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    String username = (String) session.getAttribute("username");
    int cartCount = 0;

    if(username != null){
        try{
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT SUM(quantity) FROM cart WHERE username=?"
            );
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                cartCount = (rs.getObject(1) != null) ? rs.getInt(1) : 0;
            }

            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEasy - Online Shopping</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar { background: #343a40; padding: 15px 0; }
        .search-bar { width: 400px; }
        .hero { background: linear-gradient(135deg, #ff6b6b, #ff9f43); color: white; padding: 60px 0; text-align: center; margin-bottom: 40px; }
        .product-card { border: none; border-radius: 15px; transition: transform 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .product-card:hover { transform: translateY(-5px); }
        .product-img { height: 200px; object-fit: cover; border-radius: 15px 15px 0 0; }
        .price { color: #ff6b6b; font-weight: bold; font-size: 1.1rem; }
        .category-section { margin-bottom: 50px; }

        #chatbot-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #ff6b6b;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 50%;
            font-size: 18px;
            cursor: pointer;
            z-index: 1000;
        }

        #chatbox-container {
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: 300px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            display: none; /* 👈 IMPORTANT */
            z-index: 1000;
        }

        #chatbox {
            height: 300px;
            overflow-y: auto;
            padding: 10px;
        }

        #chat-input {
            display: flex;
            border-top: 1px solid #ccc;
        }

        #chat-input input {
            flex: 1;
            border: none;
            padding: 10px;
        }

        #chat-input button {
            background: #ff6b6b;
            color: white;
            border: none;
            padding: 10px;
        }

        .user-msg {
            background: #007bff;
            color: white;
            padding: 8px;
            border-radius: 10px;
            margin: 5px;
            text-align: right;
        }

        .bot-msg {
            background: #e4e6eb;
            padding: 8px;
            border-radius: 10px;
            margin: 5px;
        }
    </style>
</head>
<body>

<%
    String logoutMsg = request.getParameter("logout");
%>

<% if (logoutMsg != null) { %>
<div class="alert alert-success alert-dismissible fade show m-0 text-center" role="alert">
    <strong><i class="fas fa-check-circle"></i> You have been logged out successfully!</strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>

<button id="chatbot-btn" onclick="toggleChat()">💬</button>

<div id="chatbox-container" style="display:none;">

    <div style="padding:5px; text-align:right;">
        <button onclick="loadHistory()">📜 History</button>
        <button onclick="clearChat()">🧹 Clear</button>
    </div>

    <div id="chatbox"></div>

    <div id="chat-input">
        <input type="text" id="userMsg" placeholder="Type message...">
        <button onclick="sendMsg()">Send</button>
    </div>

</div>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-shopping-bag me-2"></i>ShopEasy
        </a>

        <form action="search" method="post" class="d-flex mx-auto search-bar">
            <input class="form-control me-2" type="search" name="query" placeholder="Search for products..." aria-label="Search">
            <button class="btn btn-warning" type="submit"><i class="fas fa-search"></i></button>
        </form>

        <a href="cart.jsp" class="btn btn-outline-light position-relative me-3">
            🛒 Cart
            <% if(cartCount > 0){ %>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        <%= cartCount %>
                    </span>
            <% } %>
        </a>


        <div class="d-flex">
            <% if (username != null) { %>
            <span class="text-white me-3 align-self-center"><i class="fas fa-user-circle"></i> Welcome, <strong><%= username %></strong></span>
            <!-- Add Dashboard Link Here -->
            <a href="dashboard" class="btn btn-outline-light me-2"><i class="fas fa-tachometer-alt"></i> Profile</a>
            <a href="logout" class="btn btn-outline-light"><i class="fas fa-sign-out-alt"></i> Logout</a>
            <% } else { %>
            <a href="about.jsp" class="btn btn-outline-light me-2">About</a>
            <a href="contact.jsp" class="btn btn-outline-light me-2">Contact</a>
            <a href="login.jsp" class="btn btn-outline-light me-2">Login</a>
            <a href="signup.jsp" class="btn btn-outline-light me-2">Sign Up</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero">
    <div class="container">
        <h1 class="display-4 fw-bold">Welcome to ShopEasy!</h1>
        <p class="lead">Millions of Products. Great Prices.</p>
        <a href="#electronics" class="btn btn-light btn-lg mt-3">Shop Now</a>
    </div>
</div>

<!-- Products Container -->
<div class="container" id="products">

    <!-- ELECTRONICS -->
    <div class="category-section" id="electronics">
        <h3 class="mb-4 fw-bold"><i class="fas fa-laptop"></i> Electronics</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1591337676887-a217a6970a8a?w=400" class="product-img" alt="iPhone">
                    <div class="card-body"><h6 class="card-title">iPhone 15 Pro</h6><p class="text-muted small">256GB</p>
                     <span class="price">₹1,499</span>
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productName" value="iPhone 15 Pro">
                            <input type="hidden" name="price" value="999">
                            <input type="hidden" name="image"
                                   value="https://images.unsplash.com/photo-1591337676887-a217a6970a8a?w=400">

                            <div class="d-flex align-items-center">
                                <input type="number" name="quantity" value="1" min="1" max="10"
                                       class="form-control form-control-sm" style="width:70px;">

                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400" class="product-img" alt="MacBook">
                    <div class="card-body"><h6 class="card-title">MacBook Pro</h6><p class="text-muted small">M2 Chip</p>
                        <div class="d-flex justify-content-between"><span class="price">₹1,499</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="Sony WH-1000XM5">
                                <input type="hidden" name="price" value="399">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400" class="product-img" alt="Headphones">
                    <div class="card-body"><h6 class="card-title">Sony Headphones</h6>
                        <p class="text-muted small">Wireless</p><div class="d-flex justify-content-between">
                            <span class="price">₹199</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400" class="product-img" alt="Camera">
                    <div class="card-body"><h6 class="card-title">Canon Camera</h6><p class="text-muted small">4K</p>
                        <div class="d-flex justify-content-between"><span class="price">₹450</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400" class="product-img" alt="Watch">
                    <div class="card-body"><h6 class="card-title">Smart Watch</h6><p class="text-muted small">Series 8</p>
                        <div class="d-flex justify-content-between"><span class="price">₹299</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=400" class="product-img" alt="Gaming">
                    <div class="card-body"><h6 class="card-title">Gaming Laptop</h6><p class="text-muted small">RTX 4080</p>
                        <div class="d-flex justify-content-between">
                            <span class="price">₹2,199</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- FASHION -->
    <div class="category-section">
        <h3 class="mb-4 fw-bold"><i class="fas fa-tshirt"></i> Fashion</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400" class="product-img" alt="Nike">
                    <div class="card-body"><h6 class="card-title">Nike Air Max</h6><p class="text-muted small">Running</p>
                        <div class="d-flex justify-content-between"><span class="price">₹120</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400" class="product-img" alt="T-Shirt">
                    <div class="card-body"><h6 class="card-title">Cotton T-Shirt</h6><p class="text-muted small">White</p><div class="d-flex justify-content-between"><span class="price">$25</span><form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productName" value="Cotton T-Shirt"><input type="hidden" name="price" value="25"><button class="btn btn-sm btn-primary">+</button></form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400" class="product-img" alt="Watch">
                    <div class="card-body"><h6 class="card-title">Luxury Watch</h6><p class="text-muted small">Gold</p>
                        <div class="d-flex justify-content-between"><span class="price">₹299</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400" class="product-img" alt="Jacket">
                    <div class="card-body"><h6 class="card-title">Winter Jacket</h6><p class="text-muted small">Blue</p>
                        <div class="d-flex justify-content-between"><span class="price">₹150</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=400" class="product-img" alt="Shirt">
                    <div class="card-body"><h6 class="card-title">Formal Shirt</h6><p class="text-muted small">White</p>
                        <div class="d-flex justify-content-between"><span class="price">₹45</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1560347876-aeef00ee58a1?w=400" class="product-img" alt="Jeans">
                    <div class="card-body"><h6 class="card-title">Denim Jeans</h6><p class="text-muted small">Blue</p>
                        <div class="d-flex justify-content-between"><span class="price">₹60</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- HOME & KITCHEN -->
    <div class="category-section">
        <h3 class="mb-4 fw-bold"><i class="fas fa-couch"></i> Home & Kitchen</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400" class="product-img" alt="Sofa">
                    <div class="card-body"><h6 class="card-title">Modern Sofa</h6><p class="text-muted small">3 Seater</p>
                        <div class="d-flex justify-content-between"><span class="price">₹899</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=400" class="product-img" alt="Coffee">
                    <div class="card-body"><h6 class="card-title">Coffee Maker</h6><p class="text-muted small">Automatic</p>
                        <div class="d-flex justify-content-between"><span class="price">₹89</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1513694203232-719a280e022f?w=400" class="product-img" alt="Lamp">
                    <div class="card-body"><h6 class="card-title">Table Lamp</h6><p class="text-muted small">LED</p>
                        <div class="d-flex justify-content-between"><span class="price">₹45</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=400" class="product-img" alt="Bedding">
                    <div class="card-body"><h6 class="card-title">Bedsheet Set</h6><p class="text-muted small">King Size</p>
                        <div class="d-flex justify-content-between"><span class="price">₹75</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1585515320310-259814833e62?w=400" class="product-img" alt="Blender">
                    <div class="card-body"><h6 class="card-title">Mixer Grinder</h6><p class="text-muted small">750W</p>
                        <div class="d-flex justify-content-between"><span class="price">₹120</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=400" class="product-img" alt="Curtains">
                    <div class="card-body"><h6 class="card-title">Curtains</h6><p class="text-muted small">Set of 2</p>
                        <div class="d-flex justify-content-between"><span class="price">₹35</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- BEAUTY -->
    <div class="category-section">
        <h3 class="mb-4 fw-bold"><i class="fas fa-spa"></i> Beauty & Personal Care</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400" class="product-img" alt="Perfume">
                    <div class="card-body"><h6 class="card-title">Designer Perfume</h6><p class="text-muted small">50ml</p>
                        <div class="d-flex justify-content-between"><span class="price">₹89</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400" class="product-img" alt="Makeup">
                    <div class="card-body"><h6 class="card-title">Makeup Kit</h6><p class="text-muted small">Complete</p>
                        <div class="d-flex justify-content-between"><span class="price">₹65</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400" class="product-img" alt="Skincare">
                    <div class="card-body"><h6 class="card-title">Skincare Set</h6><p class="text-muted small">Anti-Aging</p>
                        <div class="d-flex justify-content-between"><span class="price">₹55</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1580870069867-74c57ee1bb07?w=400" class="product-img" alt="Hair Dryer">
                    <div class="card-body"><h6 class="card-title">Hair Dryer</h6><p class="text-muted small">2000W</p>
                        <div class="d-flex justify-content-between"><span class="price">₹45</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?w=400" class="product-img" alt="Lipstick">
                    <div class="card-body"><h6 class="card-title">Lipstick Set</h6><p class="text-muted small">Matte</p>
                        <div class="d-flex justify-content-between"><span class="price">₹30</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400" class="product-img" alt="Creams">
                    <div class="card-body"><h6 class="card-title">Face Creams</h6><p class="text-muted small">Pack of 3</p>
                        <div class="d-flex justify-content-between"><span class="price">₹40</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- SPORTS -->
    <div class="category-section">
        <h3 class="mb-4 fw-bold"><i class="fas fa-running"></i> Sports & Fitness</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400" class="product-img" alt="Treadmill">
                    <div class="card-body"><h6 class="card-title">Treadmill</h6><p class="text-muted small">Electric</p>
                        <div class="d-flex justify-content-between"><span class="price">₹899</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400" class="product-img" alt="Dumbbells">
                    <div class="card-body"><h6 class="card-title">Dumbbell Set</h6><p class="text-muted small">20kg</p>
                        <div class="d-flex justify-content-between"><span class="price">₹120</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400" class="product-img" alt="Yoga Mat">
                    <div class="card-body"><h6 class="card-title">Yoga Mat</h6><p class="text-muted small">Premium</p>
                        <div class="d-flex justify-content-between"><span class="price">$35</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1461896836934- voices4?w=400" class="product-img" alt="Cricket Bat">
                    <div class="card-body"><h6 class="card-title">Cricket Bat</h6><p class="text-muted small">Willow</p>
                        <div class="d-flex justify-content-between"><span class="price">₹85</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1517649763962-0c623066013b?w=400" class="product-img" alt="Bicycle">
                    <div class="card-body"><h6 class="card-title">Mountain Bike</h6><p class="text-muted small">21 Speed</p>
                        <div class="d-flex justify-content-between"><span class="price">₹450</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1517927033932-b3d18e61fb3a?w=400" class="product-img" alt="Football">
                    <div class="card-body"><h6 class="card-title">Football</h6><p class="text-muted" size="true">Official</p>
                        <div class="d-flex justify-content-between"><span class="price">₹25</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- BOOKS -->
    <div class="category-section">
        <h3 class="mb-4 fw-bold"><i class="fas fa-book"></i> Books</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400" class="product-img" alt="Novel">
                    <div class="card-body"><h6 class="card-title">Bestseller Novel</h6><p class="text-muted small">Fiction</p>
                        <div class="d-flex justify-content-between"><span class="price">₹15</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form>
                        </div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73?w=400" class="product-img" alt="Business">
                    <div class="card-body"><h6 class="card-title">Business Book</h6><p class="text-muted small">Leadership</p>
                        <div class="d-flex justify-content-between"><span class="price">₹20</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400" class="product-img" alt="Cookbook">
                    <div class="card-body"><h6 class="card-title">Cookbook</h6><p class="text-muted small">Recipes</p>
                        <div class="d-flex justify-content-between"><span class="price">₹25</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400" class="product-img" alt="Self Help">
                    <div class="card-body"><h6 class="card-title">Self Help Book</h6><p class="text-muted small">Motivation</p>
                        <div class="d-flex justify-content-between"><span class="price">₹18</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=400" class="product-img" alt="Biography">
                    <div class="card-body"><h6 class="card-title">Biography</h6><p class="text-muted small">Inspiring</p>
                        <div class="d-flex justify-content-between"><span class="price">₹22</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400" class="product-img" alt="Textbook">
                    <div class="card-body"><h6 class="card-title">Textbook</h6><p class="text-muted small">Education</p>
                        <div class="d-flex justify-content-between"><span class="price">₹50</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- TOYS & GAMES -->
    <div class="category-section">
        <h3 class="mb-4 fw-bold"><i class="fas fa-gamepad"></i> Toys & Games</h3>
        <div class="row">
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=400" class="product-img" alt="Gaming Console">
                    <div class="card-body"><h6 class="card-title">Gaming Console</h6><p class="text-muted small">PS5</p>
                        <div class="d-flex justify-content-between"><span class="price">₹499</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=400" class="product-img" alt="Remote Car">
                    <div class="card-body"><h6 class="card-title">Remote Car</h6><p class="text-muted small">RC</p>

                        <div class="d-flex justify-content-between"><span class="price">₹45</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?w=400" class="product-img" alt="Puzzle">
                    <div class="card-body"><h6 class="card-title">Puzzle Set</h6><p class="text-muted small">1000 pcs</p>
                        <div class="d-flex justify-content-between"><span class="price">₹25</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?w=400" class="product-img" alt="Teddy Bear">
                    <div class="card-body"><h6 class="card-title">Teddy Bear</h6><p class="text-muted small">Soft Toy</p>
                        <div class="d-flex justify-content-between"><span class="price">₹20</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?w=400" class="product-img" alt="Board Game">
                    <div class="card-body"><h6 class="card-title">Board Game</h6><p class="text-muted small">Family</p>
                        <div class="d-flex justify-content-between"><span class="price">₹35</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
            <div class="col-md-2 col-sm-4 mb-4">
                <div class="card product-card h-100">
                    <img src="https://imagesphoto-158765.unsplash.com/4780291-39c9404d746b?w=400" class="product-img" alt="Building Blocks">
                    <div class="card-body"><h6 class="card-title">Building Blocks</h6><p class="text-muted small">Kids</p>
                        <div class="d-flex justify-content-between"><span class="price">₹30</span>
                            <form action="cart" method="post" class="d-flex">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productName" value="iPhone 15 Pro">
                                <input type="hidden" name="price" value="999">
                                <input type="number" name="quantity" value="1" min="1" max="10" class="form-control" style="width: 60px;">
                                <button class="btn btn-sm btn-primary ms-2">Add</button>
                            </form></div></div>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="bg-dark text-white pt-5 pb-4 mt-5">
    <div class="container">
        <div class="row text-md-left">
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-warning">ShopEasy</h5>
                <p>Your trusted online shopping destination for quality products at affordable prices.</p>
            </div>
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Quick Links</h5>
                <p><a href="index.jsp" class="text-white" style="text-decoration: none;">Home</a></p>
                <p><a href="about.jsp" class="text-white" style="text-decoration: none;">About Us</a></p>
                <p><a href="contact.jsp" class="text-white" style="text-decoration: none;">Contact Us</a></p>
            </div>
            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Customer Service</h5>
                <p><a href="#" class="text-white" style="text-decoration: none;">Shipping Info</a></p>
                <p><a href="#" class="text-white" style="text-decoration: none;">Returns</a></p>
                <p><a href="#" class="text-white" style="text-decoration: none;">Order Status</a></p>
            </div>
            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-warning">Contact</h5>
                <p><i class="fas fa-home me-2"></i> INDIA, 10001</p>
                <p><i class="fas fa-envelope me-2"></i> support@shopeasy.com</p>
                <p><i class="fas fa-phone me-2"></i> +91 955 4556 23</p>
            </div>
        </div>
        <div class="row align-items-center mt-4">
            <div class="col-md-7 col-lg-8">
                <p>Copyright ©2026 All rights reserved by <a href="#" style="text-decoration: none;">
                    <strong class="text-warning">ShopEasy</strong></a></p>
            </div>
            <div class="col-md-5 col-lg-4">
                <div class="text-center text-md-right">
                    <a href="#" class="btn btn-outline-light btn-sm me-2"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="btn btn-outline-light btn-sm me-2"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="btn btn-outline-light btn-sm me-2"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="btn btn-outline-light btn-sm"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Auto-hide Logout Message Script -->
<script>
    window.onload = function() {
        var alertDiv = document.querySelector('.alert');
        if (alertDiv) {
            setTimeout(function() {
                var bsAlert = new bootstrap.Alert(alertDiv);
                bsAlert.close();
            }, 3000);
        }
    };
</script>


<script>
    function toggleChat() {
        let box = document.getElementById("chatbox-container");

        if (box.style.display === "none" || box.style.display === "") {
            box.style.display = "block";

            // 🔥 clear old history when opening
            document.getElementById("chatbox").innerHTML = "";
        } else {
            box.style.display = "none";
        }
    }

    function sendMsg() {
        let msg = document.getElementById("userMsg").value;
        let chatbox = document.getElementById("chatbox");

        if(msg.trim() === "") return;

        // user message
        chatbox.innerHTML += "<div class='user-msg'>" + msg + "</div>";

        // bot typing
        chatbox.innerHTML += "<div class='bot-msg' id='typing'>Typing...</div>";

        fetch("chatbot.jsp?msg=" + encodeURIComponent(msg))
            .then(res => res.text())
            .then(data => {
                document.getElementById("typing").remove();
                chatbox.innerHTML += "<div class='bot-msg'>" + data + "</div>";
                chatbox.scrollTop = chatbox.scrollHeight;
            });

        document.getElementById("userMsg").value = "";
    }
</script>

<script>
    function scrollChat() {
        var chatBox = document.getElementById("chatbox");
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    // Run when page loads
    window.onload = scrollChat;


    function loadHistory(){
        fetch("chatHistory.jsp")
            .then(res => res.text())
            .then(data => {
                let chatbox = document.getElementById("chatbox");
                chatbox.innerHTML = data;
                chatbox.scrollTop = chatbox.scrollHeight;
            });
    }

    function clearChat(){
        document.getElementById("chatbox").innerHTML = "";
    }
</script>


</body>
</html>