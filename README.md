# 🛍️ ShopEasy – Customer Relationship Management System

**ShopEasy** is a web-based **Customer Relationship Management (CRM) and e-commerce management system** designed to help businesses efficiently manage customers, leads, products, orders, payments, tasks, and user activities from a centralized platform.

The system provides separate **customer and administrator interfaces**, along with authentication, profile management, order processing, lead management, analytics, and an integrated chatbot.

---

## 📌 Project Overview

ShopEasy combines essential CRM and e-commerce functionalities into a single web application.

The system allows customers to:

* Create and manage their accounts
* Browse products
* Search for products
* Add products to a shopping cart
* Place orders
* Make payments
* Manage their profiles
* Change or reset passwords
* Interact with an integrated chatbot
* View chatbot conversation history
* Contact the organization

Administrators can:

* Manage customers
* Manage products
* Manage orders
* Manage leads
* Manage tasks
* Monitor system analytics
* Manage users
* Activate/deactivate user accounts
* Access administrative settings

---

## 🎯 Objectives

The major objectives of ShopEasy are:

1. To provide a centralized platform for customer relationship management.
2. To simplify customer and user management.
3. To manage products and orders efficiently.
4. To improve lead tracking and management.
5. To provide administrators with useful business analytics.
6. To provide secure user authentication and account management.
7. To streamline the customer purchasing process.
8. To provide an interactive chatbot for customer assistance.
9. To maintain customer information in a structured database.
10. To improve overall business and customer interaction efficiency.

---

## ✨ Key Features

### 👤 Customer Features

* User Registration
* User Login & Logout
* OTP Verification
* Forgot Password
* Password Reset
* Change Password
* User Profile Management
* Profile Image Upload
* Product Browsing
* Product Search
* Shopping Cart
* Checkout
* Payment Processing
* Order Management
* Contact Form
* Customer Dashboard

### 🛠️ CRM Features

* Customer Management
* Lead Management
* Product Management
* Order Management
* Task Management
* Customer Information Management
* User Status Management
* Business Analytics
* Administrative Dashboard

### 🤖 Chatbot

ShopEasy includes an integrated chatbot that allows users to interact with the system and maintain chatbot conversation history.

Features include:

* Chat interface
* Chat history
* Customer assistance
* Conversation management

### 🔐 Authentication & Security

* Login authentication
* Registration validation
* OTP-based verification
* Forgot password functionality
* Password reset
* Password update
* Session-based user management
* Admin access control
* User activation/deactivation

---

## 🧩 System Modules

### 1. Authentication Module

Handles:

* Registration
* Login
* Logout
* OTP verification
* Forgot password
* Reset password
* Password updates

### 2. Customer Module

Allows administrators to manage customer information and allows customers to manage their own profiles.

### 3. Product Module

Provides product-related functionality including:

* Product listing
* Product search
* Product management
* Product information

### 4. Cart & Checkout Module

Customers can:

```text
Browse Products
      ↓
Select Product
      ↓
Add to Cart
      ↓
View Cart
      ↓
Checkout
      ↓
Payment
      ↓
Order Confirmation
```

### 5. Lead Management Module

Administrators can manage potential customers and track leads through the CRM system.

### 6. Order Management Module

Administrators can view and manage customer orders while customers can complete the purchasing workflow.

### 7. Task Management Module

The administrator dashboard provides task management functionality for organizing CRM-related activities.

### 8. Analytics Module

Provides administrators with an overview of business-related information through the analytics dashboard.

### 9. Chatbot Module

Provides an interactive chatbot interface and stores conversation history for users.

### 10. Profile Management Module

Users can:

* View profile
* Update profile
* Upload profile image
* Change password

---

## 🏗️ System Architecture

ShopEasy follows a **Java Servlet–JSP based web application architecture**.

```text
                ┌─────────────────────┐
                │      User / Admin   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │     JSP Interface   │
                │   HTML / CSS / UI   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │    Java Servlets    │
                │ Business Logic Layer│
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   DB Connection     │
                │      JDBC           │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   MySQL Database    │
                └─────────────────────┘
```

---

## 💻 Technology Stack

| Technology                  | Purpose                             |
| --------------------------- | ----------------------------------- |
| **Java 17**                 | Backend development                 |
| **Jakarta Servlets 5.0**    | Request handling and business logic |
| **JSP**                     | Dynamic web pages                   |
| **HTML5**                   | Page structure                      |
| **CSS3**                    | Styling and UI                      |
| **JavaScript**              | Client-side functionality           |
| **MySQL**                   | Database management                 |
| **JDBC**                    | Database connectivity               |
| **Maven**                   | Project and dependency management   |
| **Jakarta Mail**            | Email-related functionality         |
| **Apache Tomcat**           | Application server                  |
| **IntelliJ IDEA / Eclipse** | Development environment             |

---

## 📂 Project Structure

```text
CRMSystem/
│
└── CRMSystem/
    └── CRMSystem/
        │
        ├── pom.xml
        ├── .gitignore
        │
        └── src/
            └── main/
                │
                ├── java/
                │   ├── com/
                │   │   └── crm/
                │   │       ├── CartItem.java
                │   │       ├── CartServlet.java
                │   │       ├── ContactServlet.java
                │   │       ├── CRMAdminServlet.java
                │   │       ├── CustomerServlet.java
                │   │       ├── DashboardServlet.java
                │   │       ├── DeleteUserServlet.java
                │   │       ├── ForgotPasswordServlet.java
                │   │       ├── LeadManagementServlet.java
                │   │       ├── LoginServlet.java
                │   │       ├── LogoutServlet.java
                │   │       ├── PaymentServlet.java
                │   │       ├── ProductServlet.java
                │   │       ├── ProfileServlet.java
                │   │       ├── ResetPasswordServlet.java
                │   │       ├── SearchServlet.java
                │   │       ├── SignupServlet.java
                │   │       ├── ToggleUserStatusServlet.java
                │   │       ├── UpdatePasswordServlet.java
                │   │       ├── UserDashboardServlet.java
                │   │       └── VerifyOTPServlet.java
                │   │
                │   └── util/
                │       └── DBConnection.java
                │
                ├── resources/
                │
                └── webapp/
                    ├── index.jsp
                    ├── login.jsp
                    ├── signup.jsp
                    ├── dashboard.jsp
                    ├── product.jsp
                    ├── cart.jsp
                    ├── checkout.jsp
                    ├── payment.jsp
                    ├── profile.jsp
                    ├── chatbot.jsp
                    ├── chatHistory.jsp
                    ├── contact.jsp
                    │
                    ├── admin/
                    │   ├── dashboard.jsp
                    │   ├── customers.jsp
                    │   ├── products.jsp
                    │   ├── orders.jsp
                    │   ├── lead.jsp
                    │   ├── tasks.jsp
                    │   ├── analytics.jsp
                    │   └── settings.jsp
                    │
                    └── WEB-INF/
                        └── web.xml
```

---

## ⚙️ Maven Dependencies

The project uses Maven for dependency management.

Major dependencies include:

* Jakarta Servlet API
* MySQL Connector/J
* Jakarta Mail
* JUnit

The project is configured for **Java 17** and generates a WAR package.

---

## 🚀 Installation & Setup

### Prerequisites

Before running ShopEasy, install:

* Java JDK 17 or later
* Apache Maven
* MySQL Server
* Apache Tomcat compatible with Jakarta Servlet 5
* IntelliJ IDEA, Eclipse, or another Java IDE

---

### 1. Clone the Repository

```bash
git clone https://github.com/https://github.com/malavikamanoj640-tech/Customer-Relationship-Management-System/ShopEasy-CRM.git
```

Navigate to the project:

```bash
cd ShopEasy-CRM
```

---

### 2. Configure MySQL

Create the required MySQL database and tables according to the project's database configuration.

Update the database connection settings in:

```text
src/main/java/util/DBConnection.java
```

Configure:

```text
Database URL
Username
Password
Database Name
```


---

### 3. Build the Project

Run:

```bash
mvn clean install
```

The WAR file will be generated in:

```text
target/crm.war
```

---

### 4. Deploy on Apache Tomcat

Copy the generated WAR file into the Tomcat `webapps` directory.

For example:

```text
apache-tomcat/
└── webapps/
    └── crm.war
```

Start Tomcat and access the application through:

```text
http://localhost:8080/crm/
```

---

## 🔄 Application Workflow

```text
                    SHOP EASY
                        │
             ┌──────────┴──────────┐
             │                     │
          Customer              Admin
             │                     │
       ┌─────┴─────┐       ┌───────┴────────┐
       │           │       │                │
    Register     Login   Dashboard      User Management
       │           │       │                │
       └─────┬─────┘       ├── Customers
             │              ├── Products
          Dashboard         ├── Orders
             │              ├── Leads
      ┌──────┼──────┐       ├── Tasks
      │      │      │       └── Analytics
   Products Cart  Profile
      │      │
      └──┬───┘
         │
      Checkout
         │
      Payment
         │
    Order Complete
```

---

## 🗄️ Database

ShopEasy uses **MySQL** as its relational database.

The database is responsible for maintaining application data such as:

* Users
* Customers
* Products
* Orders
* Leads
* Tasks
* Chat history
* Profile information
* Authentication-related information

The application communicates with MySQL using **JDBC**.

---

## 👨‍💼 Admin Dashboard

The administrative dashboard provides centralized management of the CRM system.

### Admin capabilities include:

* Dashboard overview
* Customer management
* Product management
* Order management
* Lead management
* Task management
* Analytics
* User management
* User status control
* Administrative settings

---

## 👤 Customer Dashboard

The customer dashboard provides access to:

* Products
* Search
* Shopping cart
* Checkout
* Payments
* Profile
* Password management
* Chatbot
* Chat history
* Contact functionality

---

## 🔐 Security Considerations

The application implements several account-management and security-related mechanisms:

* Authentication
* Session management
* OTP verification
* Password reset workflow
* User status management
* Admin/user separation
* Database-backed authentication

For production deployment, additional security practices should be considered, including:

* Secure password hashing
* Environment-based database credentials
* HTTPS
* CSRF protection
* Input validation
* SQL injection protection
* Secure session configuration
* Proper secret management

---

## 📊 Main Functional Areas

```text
┌──────────────────────────────────────────┐
│              ShopEasy CRM                │
├──────────────────────────────────────────┤
│ Authentication                           │
│ Customer Management                      │
│ Product Management                       │
│ Lead Management                          │
│ Order Management                         │
│ Task Management                          │
│ Payment Processing                       │
│ Analytics                                │
│ Profile Management                       │
│ Chatbot & Chat History                   │
└──────────────────────────────────────────┘
```

---

## 🌟 Highlights

* Full-stack Java web application
* MVC-style Servlet/JSP architecture
* Customer and administrator interfaces
* CRM + e-commerce functionality
* MySQL database integration
* Product and order management
* Lead management
* Admin analytics
* OTP-based verification
* Password recovery
* Profile management
* Integrated chatbot
* Maven-based project
* Java 17 support

---

## 🔮 Future Enhancements

Possible future improvements include:

* REST API integration
* Advanced sales analytics
* Real-time notifications
* Email and SMS notifications
* Advanced lead conversion tracking
* Customer segmentation
* AI-powered product recommendations
* AI-based sales forecasting
* Role-based access control
* Advanced reporting and export
* Responsive mobile-first interface
* Payment gateway integration
* Docker deployment
* Cloud deployment
* Automated testing and CI/CD

---

## 🧪 Testing

The application can be tested across the following areas:

* User registration
* Login and logout
* OTP verification
* Password recovery
* Product search
* Cart operations
* Checkout
* Payment
* Customer management
* Lead management
* Order management
* Product management
* Admin dashboard
* Profile management
* Chatbot functionality

---

## 📸 Screenshots

<img width="1915" height="897" alt="CRM1" src="https://github.com/user-attachments/assets/a96781de-0f1a-45d6-9f17-05b39df83ec9" />

<img width="1353" height="911" alt="CRM2" src="https://github.com/user-attachments/assets/8580dda6-e4d0-4a24-9a0a-0e3b94d71f6e" />

<img width="1036" height="877" alt="CRM3" src="https://github.com/user-attachments/assets/ddcb57e8-dbc2-431b-a809-fb204462545f" />

**AFTER LOGGING IN**
<img width="1891" height="913" alt="CRM5" src="https://github.com/user-attachments/assets/f5b90cdc-4936-4dad-9862-1f957398ae03" />

<img width="1685" height="913" alt="CRM6" src="https://github.com/user-attachments/assets/26539f1c-5b20-4256-a120-9d92b0791594" />

<img width="1118" height="892" alt="CRM7" src="https://github.com/user-attachments/assets/fcd50e25-d332-4cca-838c-9465c459d100" />

<img width="1147" height="876" alt="CRM8" src="https://github.com/user-attachments/assets/284a029a-9286-4bdc-803b-b3069d441082" />

<img width="1847" height="727" alt="CRM11" src="https://github.com/user-attachments/assets/5f6d88ee-c5e2-4585-ad6d-cb54101a4c8d" />

<img width="606" height="792" alt="CRM12" src="https://github.com/user-attachments/assets/30c7e74e-2a95-4c36-9a37-bbaaa6a05e76" />



**USER DASHBOARD**

<img width="1913" height="901" alt="CRM10" src="https://github.com/user-attachments/assets/3c6faab6-6306-46cf-9063-fdbc6af84b9d" />


**ADMIN DASHBOARD**

<img width="1882" height="882" alt="crm13" src="https://github.com/user-attachments/assets/40c358b2-ba57-479b-aca5-e202a843db89" />

<img width="1722" height="782" alt="crm14" src="https://github.com/user-attachments/assets/4a256e85-65b8-4e18-89e3-0a2880b59c49" />

<img width="1707" height="877" alt="CRM15" src="https://github.com/user-attachments/assets/a71dc131-5ea4-470d-8d15-155a6d93cf4c" />

<img width="1705" height="803" alt="CRM16" src="https://github.com/user-attachments/assets/3909da31-2a50-4b94-9376-e88df240a833" />

<img width="1533" height="902" alt="CRM18" src="https://github.com/user-attachments/assets/9a6ff403-8079-431b-819d-af51f0d02980" />



---

## 📄 License

This project is developed for educational and project-development purposes.

---

## 👩‍💻 Developed By

**ShopEasy Development Team**

A CRM and e-commerce web application developed using **Java, JSP, Servlets, MySQL, JDBC, HTML, CSS and JavaScript**.

---

⭐ If you find this project useful, consider giving the repository a **Star**.
