<%@ page contentType="text/html; charset=utf-8" language="java" import="java.io.*" errorPage=""
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Pizza Shop : Address Confirmation</title>
</head>
  <body bgcolor="black">
      <div style="margin-left:30px;">
      
	<font color="white"><center><h1>VRaJ's Pizza Shop [Confirm Order]</h1></center>
    <hr width="60%" />
    <table width="100%"><tr><td width="70%">
        <h3 style="margin-left:230px;"># ORDER DETAILS </h3> 
        <center>
	<table border=1 width="50%" cellspacing=10 cellpading=6 id="items">
		<tr bgcolor="brown">
			<th width="10%">#</th>
			<th width="65%"><font color="white">ITEM NAME</font></th>
			<th width="25%"><font color="white">ITEM PRICE</font></th>
        </tr>    
				<% 
					int x;
                    String[] items=request.getParameter("items").split(",");
                    String[] price=request.getParameter("price").split(",");
                    for(x=0; x<items.length; x++){
                        out.print("<tr>");
                            out.println("<td><center><b>"+(x+1)+"</td>");
                            out.println("<td><center><b>"+items[x]+"</td>");
                            out.println("<td><center><b>"+price[x]+".00 /-</td>");
                        out.print("</tr>");
                    }
                %>
     	<tr>
			<th width="10%"></th>
			<th width="65%"></th>
			<th width="25%" bgcolor="brown"><font color="white"><center><b>Rs. <% out.print(request.getParameter("total"));%></font></th>
        </tr>
	</table>
    </center>
    <br />
    <hr width="60%" />
    </td><td>
    <h3 style=""># CUSTOMER DETAILS </h3> 
		<form action="step0.jsp" method="post">
		<h4>Name<br />
        <input type="text" name="fname" placeholder="Customer Name" size="40" autofocus="autofocus" required="required" />
        <br />
        <br />
        Street / House No.<br />
        <textarea name="street" cols="30" placeholder="Full Address" required="required"></textarea>
        <br />
        <br />
        City<br />
        <input type="text" name="city" placeholder="E.g. Shirdi" size="40" required="required" />
        <br />
        <br />
        Nearest Landmark<br />
        <input type="text" name="landmark" placeholder="E.g. Saibaba Temple" size="40" required="required" />
        <br /><br />
        Mobile No.<br />
        <input type="text" name="mobile" placeholder="E.g. 9876543210" size="40" required />
		<br /><br />
        <input type="hidden" name="items" value="<% out.print(request.getParameter("items"));%>" />
        <input type="hidden" name="price" value="<% out.print(request.getParameter("price"));%>" />
        <input type="hidden" name="total" value="<% out.print(request.getParameter("total"));%>" />
        <input type="submit" value="Confirm / Place Order" class="" /> <input type="reset" value="Reset" />
        </h4></form>
    </td>
    </tr></table>
    </div>
</body>
</html>
