<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>kanishk's Grocery Order List</title>
</head>
<body>
<div class="header">

	<div class="header-right">
		<a class="active" href="listprod.jsp">products</a>
		<a href="listorder.jsp">Orders</a>
		<a href="showcart.jsp">Cart</a>
		<a href="shop.html">Home</a>
	</div>
</div>

<h1>Order List</h1>

<%
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kverma;";
	String uid = "kverma";
	String pw = "41062175";

	try (



			Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt2 = con.createStatement();
	) {
		String y = "SELECT * FROM ordersummary;";
		ResultSet rst2 = stmt2.executeQuery("SELECT * FROM ordersummary;");
		int orderid;



		while (rst2.next()) {
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			orderid = rst2.getInt("orderId");
			out.print("<table border=1>" + "<tr>" + "<th>" + "Order Id" + "</th>" + "<th>" + "Order Date" + "</th><th>" + "Total Amount" + "</th><th>" + "Customer Id" + "</th></tr>");
			out.print("<tr>" + "<td>"+orderid+"</td>"  + "<td>" +


					rst2.getDate("orderDate") + "</td>" + "<td>" +
					currFormat.format((double)rst2.getDouble("TotalAmount")) + "</td>" + "<td>" +
					rst2.getInt("customerId") + "</td></tr>");

					out.print("<tr align=right>"+ "<td colspan=5>"+ "<table border=1>");
					out.print("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr >");


					String z = "SELECT productId, quantity, price  FROM orderproduct WHERE orderId = ?;";
					PreparedStatement stmt3 = con.prepareStatement(z);
					stmt3.setInt(1, orderid);
					ResultSet rst3 = stmt3.executeQuery();

					while (rst3.next()) {

						out.print("<tr><td>"+rst3.getInt(1)+"</td><td>"+rst3.getInt(2)+"</td><td>"+currFormat.format(rst3.getDouble(3))+"</td></tr>");

					}
						out.print("</table></td></tr>");





		 	}out.print("</table>"); }







	catch (SQLException e) {
	e.printStackTrace();
	}





// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
	// Write out product information

// Close connection
%>


</body>
</html>

