package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        // All products database
        List<String[]> allProducts = new ArrayList<>();
        allProducts.add(new String[]{"1", "iPhone 15 Pro", "999", "https://images.unsplash.com/photo-1591337676887-a217a6970a8a?w=400", "Electronics", "Latest Apple Phone with A17 chip, 256GB storage, titanium design."});
        allProducts.add(new String[]{"2", "MacBook Pro", "1499", "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400", "Electronics", "M2 Chip, 16GB RAM, 512GB SSD, 14-inch display."});
        allProducts.add(new String[]{"3", "Sony Headphones", "199", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400", "Electronics", "Wireless noise cancelling headphones with 30-hour battery."});
        allProducts.add(new String[]{"4", "Canon Camera", "450", "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400", "Electronics", "45MP Mirrorless Camera, 8K video recording."});
        allProducts.add(new String[]{"5", "Smart Watch", "299", "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400", "Electronics", "Fitness tracker with heart rate monitor, GPS."});
        allProducts.add(new String[]{"6", "Gaming Laptop", "2199", "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=400", "Electronics", "RTX 4080, 32GB RAM, 1TB SSD, 240Hz display."});
        allProducts.add(new String[]{"7", "Nike Air Max", "120", "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400", "Fashion", "Comfortable running shoes with air cushioning."});
        allProducts.add(new String[]{"8", "Cotton T-Shirt", "25", "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400", "Fashion", "100% cotton, comfortable fit, multiple colors."});
        allProducts.add(new String[]{"9", "Luxury Watch", "299", "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400", "Fashion", "Elegant analog watch with leather strap."});
        allProducts.add(new String[]{"10", "Winter Jacket", "150", "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400", "Fashion", "Waterproof, warm, stylish winter jacket."});

        String[] selectedProduct = null;
        List<String[]> relatedProducts = new ArrayList<>();
        String category = "";

        for (String[] product : allProducts) {
            if (product[0].equals(id)) {
                selectedProduct = product;
                category = product[4];
                break;
            }
        }

        // Get related products (same category)
        for (String[] product : allProducts) {
            if (product[4].equals(category) && !product[0].equals(id)) {
                relatedProducts.add(product);
            }
        }

        request.setAttribute("product", selectedProduct);
        request.setAttribute("related", relatedProducts);
        request.getRequestDispatcher("product.jsp").forward(request, response);
    }
}