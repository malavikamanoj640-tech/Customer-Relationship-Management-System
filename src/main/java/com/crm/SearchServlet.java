package com.crm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");

        // Product Database (Name, Price, Image URL, Description)
        List<String[]> products = new ArrayList<>();
        products.add(new String[]{"Nike Air Max", "120", "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400", "Running Shoes"});
        products.add(new String[]{"Sony Headphones", "199", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400", "Wireless Audio"});
        products.add(new String[]{"Smart Watch", "89", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400", "Fitness Tracker"});
        products.add(new String[]{"Canon Camera", "450", "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400", "4K Photography"});
        products.add(new String[]{"iPhone 15", "999", "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400", "Latest Apple Phone"});
        products.add(new String[]{"MacBook Pro", "1500", "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400", "Laptop"});

        List<String[]> results = new ArrayList<>();

        if (query != null && !query.isEmpty()) {
            for (String[] product : products) {
                if (product[0].toLowerCase().contains(query.toLowerCase()) ||
                        product[3].toLowerCase().contains(query.toLowerCase())) {
                    results.add(product);
                }
            }
        }

        request.setAttribute("searchQuery", query);
        request.setAttribute("results", results);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}