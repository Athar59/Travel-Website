<%@ include file="header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <section class="payment-section">
        <div class="payment-container">
            <h2 class="payment-title">Payment Page</h2>

            <%
                // Retrieving package details from session
                String packageId = (String) session.getAttribute("package_id");
                String packageName = (String) session.getAttribute("package_name");
                Double packagePrice = (Double) session.getAttribute("total_price");

                // Checking if the required details are missing from session
                if (packageId == null || packageName == null || packagePrice == null || packagePrice == 0.0) {
                    response.sendRedirect("booking_failed.jsp");
                    return;
                }
            %>

            <p class="payment-package"><strong>Package:</strong> <%= packageName %></p>
            <p class="payment-price"><strong>Price per Person:</strong> $<%= packagePrice %></p>

            <form action="PaymentServlet" method="post" class="payment-form">
                <input type="hidden" name="package_id" value="<%= packageId %>">
                <input type="hidden" name="package_name" value="<%= packageName %>">
                <input type="hidden" id="package_price" value="<%= packagePrice %>">
                <input type="hidden" name="total_price" id="total_price" value="<%= packagePrice %>">

                <div class="payment-form-group">
                    <label for="mode_of_travel" class="payment-label">Mode of Travel:</label>
                    <select id="mode_of_travel" name="mode_of_travel" class="payment-input" required>
                        <option value="Flight">Flight</option>
                        <option value="Train">Train</option>
                        <option value="Bus">Bus</option>
                    </select>
                </div>

                <div class="payment-form-group">
                    <label for="num_persons" class="payment-label">Number of Persons:</label>
                    <input type="number" id="num_persons" name="num_persons" class="payment-input" min="1" required value="1" oninput="updateTotalPrice()">
                </div>

                <div class="payment-form-group">
                    <label for="card" class="payment-label">Enter Card Details:</label>
                    <input type="text" id="card" name="card_details" class="payment-input" placeholder="**** **** **** ****" required>
                </div>

                <div class="payment-form-group">
                    <p><strong>Total Price: </strong> $<span id="total_price_display"><%= packagePrice %></span></p>
                </div>

                <button type="submit" class="payment-btn">Pay Now</button>
            </form>
        </div>
    </section>
    <script src="js/script.js"></script>
</body>
</html>

<%@ include file="footer.jsp" %>
